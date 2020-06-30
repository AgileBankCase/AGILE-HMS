<!DOCTYPE html>
<html>
<head>
<style>
body {
	background: #ece6e6,
	
}
html {
  scroll-behavior: smooth;
}

.main-section {
	position: relative;
	color: black
}

.medicine {
	
	position: relative;
	color: black
}

.additional {
	
	position: relative;
	color: black
}
</style>
</head>
<body bgcolor=#E6E6FA>
	<jsp:include page="header2.jsp" />

	<div class="main-section">
		
		<center>
			<h1 align='center'>Pharmacy</h1>
			<table border="1" cellpadding='0' cellspacing='0' width="700px"
				align='center' id="view_patients">
				<tr>
					<th>Patient ID</th>
					<th>Name</th>
					<th>Age</th>
					<th>Address</th>
					<th>DOJ</th>
					<th>Type of BED</th>
				</tr>
				<tr>
					<td><input id="patId" name='patId' pattern="[0-9]{9}"
						width='480px' required>
					<button onclick="viewPatientDetail(event)" name="learn"
							value="myimage">
							<img src="https://img.icons8.com/ios/13/000000/search--v1.png" />
						</button> <input type="hidden" id="patId2"></td>
					<td><span id="name"></span></td>
					<td><span id="age"></span></td>
					<td><span id="address"></span></td>
					<td><span id="doj"></span></td>
					<td><span id="bed"></span></td>
				</tr>
			</table>
			<br><br>
	<div class="medicine hide" id="meddiv">
		<center>
			<h1 align='center'>Medicines Issued</h1>
			<table border="1" cellpadding='0' cellspacing='0' width='480px'
				align='center' id="issuedMedicine" >
				
			</table>
			<br> <br>
			<button onclick='issue()' name="issue medicine"
				align='center'>Issue Medicine</button>
	</div>
	<div class="additional hide" id="adddiv">
		<center>
			<h1 align='center'>Issue Medicine</h1>
			<table border="1" cellpadding='0' cellspacing='0' width='480px'
				align='center' id="">
				<tr>
					<th>Medicine</th>
					<th>Quantity</th>
					<th>Rate</th>
					<th>Amount</th>
				</tr>
				<tr>
				<td><input id="medName" ><button onclick="rateFill(event)" name="learn"
							value="myimage">
							<img src="https://img.icons8.com/ios/13/000000/search--v1.png" />
						</button></td>
				<td><input id="quan" disabled="true" type="number" min="1" value="1" onchange="amountFill()"></td>
				<td>Rs.<span id="rate">0</span></td>
				<td><span id="amount"></span></td>
				</tr>
			</table>
			<br> <br>
			<button onclick="addMed(event)" name="add" align='center'>ADD</button>
	</div>
	</div>
	
	<script type="text/javascript">
		function issue()
		{
			$("#adddiv").attr("class","additional");
			$("#medName").focus();
			 window.scrollBy(0, 100);
		}
		function viewPatientDetail(event) {
			event.preventDefault();
			$.ajax({
				method : "get",
				url : "/patient?patId=" + $('#patId').val(),
				success : function(data) {

					var json = JSON.parse(data);
					if (json["status"] != undefined) {
						alert(json["status"]);
					} else {
						var patient_details = [];
						patient_details = json["patient_details"];
						if (patient_details.length != 0) {
							var user = "";
							user = patient_details[0];

							$("#patId2").val(user["patient_ID"]);

							$("#name").html(user["name"]);

							$("#age").html(user["age"]);
							$("#doj").html(user["DOA"]);
							$("#bed").html(user["type_of_bed"]);
							$("#address").html(user["address"]);
							renderIssuedMedicine();
						
						} else {
							alert("Please Enter Valid Patient ID");
						}
					}
				}
			});

		}
		function addMed(event){
			event.preventDefault();
			$.ajax({
				method:"post",
				url:"/medicine?medName="+$("#medName").val()+"&issueQuantity="+$("#quan").val()+"&patId=" + $("#patId2").val(),
				success:function (data){
					var json = JSON.parse(data);
					if(json["status"]!="Succesfully Added!"){
						alert(json["status"]);
					}
					else {
						renderIssuedMedicine();
						
					}
				}
				});
		}
		function resetAddMed(disableName){
			if(disableName){
				$("#medName").val("");
			}
			$("#quan").val("1");
			$("#quan").attr("disabled","true");
			$("#rate").html("0");
			$("#amount").html("Rs.0");
		}
		function rateFill(event){
			event.preventDefault();
			$.ajax({
				method:"get",
				url:"/medicine?medName="+$("#medName").val(),
				success:function (data){
					var json = JSON.parse(data);
					if(json["status"]!=undefined){
						alert(json["status"]);
						resetAddMed(false);
					}
					else {
						var patient_details=[];
						patient_details=json["Medicine_Details"];
						if (patient_details.length != 0) {
							var user = "";
							user = patient_details[0];

							$("#rate").html(user["rate"]);
							amountFill();
							$("#quan").attr("max",user["quantity"]);
							$("#quan").removeAttr("disabled");
						}

					}
				}
				
			});
		}
		function amountFill(){
			var amount=0;
			amount=parseInt($("#quan").val()) * parseInt($("#rate").html());
			$("#amount").html("Rs."+amount);
		}
		function renderIssuedMedicine(){
			$.ajax({
				method : "get",
				url : "/medicine?patId="+$('#patId').val(),
				success : function(data)
				{
					
					var json = JSON.parse(data);
					if(json["status"]!=undefined){
						alert(json["status"]);
					}
					else {
						var patient_details=[];
						patient_details=json["Patient_Medicine_Details"];
						var patient_data ='';
						$('#issuedMedicine').html("");
						 patient_data+="<tr>"+
						      "<th>Medicine</th>"+
						      "<th>Quantity</th>"+
						      "<th>Rate</th>"+
						      "<th>Amount</th>"+
						    "</tr>";
						 $('#issuedMedicine').append(patient_data);

						if(patient_details.length!=0)
						{
							patient_data ='';
							patient_details.forEach(user => 
							{
								 patient_data += '<tr>';
						            patient_data += '<td>'+user["medicine_name"]+'</td>';
						            patient_data += '<td>'+user["issued_quantity"]+'</td>';
						            patient_data += '<td>'+user["rate"]+'</td>';
						            patient_data += '<td>'+user["amount"]+'</td>';
						            patient_data += '</tr>';
						    });
						       $('#issuedMedicine').append(patient_data);
								
							$("#meddiv").attr("class","medicine");
							resetAddMed(true);
							$("#adddiv").attr("class","additional hide");
						}
						
					}
				}
          });

		}
	</script>
</body>
</html>