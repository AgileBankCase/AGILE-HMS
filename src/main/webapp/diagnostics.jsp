<!DOCTYPE html>
<html>
<head>
<style>
body {
	background: #ece6e6
}

.main-section {
	position: relative;
	color: black
}

.diagnostics {
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
	<jsp:include page="header3.jsp" />

	<div class="main-section">
		<br>
		<center>
			<h1 align='center'>Diagnostics</h1>
			<table border="1" cellpadding='0' cellspacing='0' width='700px'
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
					<td>
					<input id="patId" name='patId' pattern="[0-9]{9}" width='480px' required>
					<button onclick="viewPatientDetail(event)" name="learn" value="myimage">
					<img src="https://img.icons8.com/ios/13/000000/search--v1.png" />
					</button>
					<input type="hidden" id="patId2">
					<input type="hidden" id="status">
					</td>
					<td><span id="name"></span></td>
					<td><span id="age"></span></td>
					<td><span id="address"></span></td>
					<td><span id="doj"></span></td>
					<td><span id="bed"></span></td>
				</tr>
			</table>
	</div>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<div id="diagdiv" class="diagnostics hide">
		<center>
			<h1 align='center'>Diagnostics conducted</h1>
			<table border="1" cellpadding='0' cellspacing='0' width='320px'
				align='center' id="issuedDiagnostics">
				
			</table>
			<br> <br>
			<button onclick="adddiagno()" name="add diagnostics"
				align='center'>Add diagnostics</button>
	</div>
	<br><br>
	<div class="additional hide" id="adddiv">
		<table border="1" cellpadding='0' cellspacing='0' width='320px'
			align='center' id="">
			<tr>
				<th>Name of the test</th>
				<th>Amount</th>
			</tr>
			<tr>
				<td><input id="testName" ><button onclick="amountFill(event)" name="learn"
							value="myimage">
							<img src="https://img.icons8.com/ios/13/000000/search--v1.png" />
						</button></td>
				
				<td><span id="amount">Rs.0</span></td>
				</tr>
		</table>
		<br> <br>
		<center>
			<button onclick="issueDiagno(event)" name="add" align='center'>ADD</button>
	</div>
	<script type="text/javascript">
	function adddiagno()
	{
		if($("#status").val()=="active")
		{
		$("#adddiv").attr("class","additional");
		$("#testName").focus();
		 window.scrollBy(0, 200);
		}
		else
		{
			alert("Cannot Add Diagnostic to Disharged Patient");
		}
		
	}
		function viewPatientDetail(event) {
			event.preventDefault();
			$.ajax({
				method : "get",
				url : "/patient?patId=" + $("#patId").val(),
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
							$("#status").val(user["status"]);
							renderIssuedDiagnostics();

						} else {
							alert("Please Enter Valid Patient ID");
						}
					}
				}
			});

		}
		function amountFill(event){
			event.preventDefault();
			$.ajax({
				method:"get",
				url:"/diagno?testName="+$("#testName").val(),
				success:function (data){
					var json = JSON.parse(data);
					if(json["status"]!=undefined){
						alert(json["status"]);
						resetAdddiagnostic(false)
					}
					else {
						var patient_details=[];
						patient_details=json["Diagnostic_Details"];
						if (patient_details.length != 0) {
							var user = "";
							user = patient_details[0];

							$("#amount").html("Rs."+user["amount"]);
						}

					}
				}
				
			});
		}
		function renderIssuedDiagnostics(){
			$.ajax({
				method : "get",
				url : "/diagno?patId="+$('#patId2').val(),
				success : function(data)
				{
					
					var json = JSON.parse(data);
					if(json["status"]!=undefined){
						alert(json["status"]);
					}
					else {
						var patient_details=[];
						patient_details=json["Patient_Diagnostic_Details"];
						var patient_data ='';
						$('#issuedDiagnostics').html("");
						 patient_data+="<tr>"+
						      "<th>Name of the test</th>"+
						      "<th>Amount</th>"+
						    "</tr>";
						 $('#issuedDiagnostics').append(patient_data);

						if(patient_details.length!=0)
						{
							patient_data ='';
							patient_details.forEach(user => 
							{
								 patient_data += '<tr>';
						            patient_data += '<td>'+user["test_name"]+'</td>';
						            patient_data += '<td>'+user["amount"]+'</td>';
						            patient_data += '</tr>';
						    });
						       $('#issuedDiagnostics').append(patient_data);
								
							
						}
						$("#diagdiv").attr("class","medicine");
						//resetAddMed(true);
						$("#adddiv").attr("class","additional hide");
						
					}
				}
          });

		}
		function issueDiagno(event){
			event.preventDefault();
			$.ajax({
				method:"post",
				url:"/diagno?testName="+$("#testName").val()+"&patId=" + $("#patId2").val(),
				success:function (data){
					var json = JSON.parse(data);
					if(json["status"]!="Test Succesfully Added!"){
						alert(json["status"]);
						resetAdddiagnostic(false);
					}
					else {
						renderIssuedDiagnostics();
						resetAdddiagnostic(true);
					}
				}
				});
		}
		function resetAdddiagnostic(disableName){
			if(disableName){
				$("#testName").val("");
			}
			$("#amount").html("Rs.0");
		}
	</script>
</body>
</html>