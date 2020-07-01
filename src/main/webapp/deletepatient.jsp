<!DOCTYPE html>
<html>
<head>
<style>
body {
	font-family: 'Lato', sans-serif;
	position: relative;
	background: #ece6e6;
	margin: 20px;
}

.main-section {
	color: black;
}
</style>
</head>
<body bgcolor=#E6E6FA>
	<jsp:include page="header1.jsp" />
	<div class="main-section">
		<table border='0' width='480px' cellpadding='0' cellspacing='0'
			align='center'>
			<center>
				<tr>
					<td colspan='2'><h1 align='center'>Delete Patient</h1></td>
				</tr>
				<center>
			<tr>
				<td align='left'>Patient Id</td>
				<td><input id="pat-id" name='patId' pattern="[0-9]{9}" required>
				<button onclick="get(event)">Get</button><input type="hidden" id="status"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
		<table id="deletepatient" class="hide"  border='0' width='480px' cellpadding='0' cellspacing='0'
			align='center'>
			<tr>
				<td align='left'>Patient SSN Id</td>
				<td><span id="ssnID"></span><input type="hidden" id="patId"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>

			<tr>
				<td align='left'>Patient Name</td>
				<td><span id="name"></span></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align='left'>Patient Age</td>
				<td><span id="age"></span></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align='left'>Date of Admission</td>

				<td><span id="doj"></span></td>

			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align='left'>Type of Bed</td>
				<td><span id="bed"></span><br /> <br /></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align='left'>Address</td>
				<td><span id="addr"></span></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align='left'>City</td>
				<td><span id="city"></span><br /> <br /></td>

			</tr>

			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align='left'>State</td>
				<td><span id="state"></span><br /> <br /></td>

			</tr>
			<tr>
				<td align='center'><button onclick="deletePatient(event)">Delete</button></td>
				<td align='center'><button onclick="cancelEvent(event)">Cancel</button></td>

			</tr>


		</table>
	</div>
</body>
<script>
	
	function deletePatient(event) {
		event.preventDefault();
		if(confirm("Are you sure you want to delete?")){
			$.ajax({
				type : "delete",
				url : "/patient?patId=" + $("#patId").val(),
				success : function(data) {
					var json = JSON.parse(data);
					alert(json["status"]);
					if (json["status"] == "Succesfully Deleted!") {
						document.location.reload();
					}
					
				}
			});
			}
    }
    function get(event)
{
	event.preventDefault();

    $.ajax(
		{
				method : "get",
				url : "/patient?patId=" + $("#pat-id").val(),
				
				success : function(data)
				 {
					var json = JSON.parse(data);
					var patient_details=[];
					patient_details=json["patient_details"];
					if(patient_details.length!=0)
					{
						 
							patient_details.forEach(user => 
							{
								$("#ssnID").html(user["SSN_ID"]);
								$("#patId").val(user["patient_ID"]);
								$("#name").html(user["name"]);
								$("#age").html(user["age"]);
								$("#doj").html(user["DOA"]);
								$("#bed").html(user["type_of_bed"]);
								$("#addr").html(user["address"]);
								$("#city").html(user["city"]);
								$("#state").html(user["state"]);
								$("#status").val(user["status"]);

							});
							$("#deletepatient").attr("class","");
					}else
					{

						alert("No patient found with given ID !");
					}
				}
			});
		}
		</script>

</html>