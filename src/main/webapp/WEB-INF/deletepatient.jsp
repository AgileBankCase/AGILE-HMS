<!DOCTYPE html>
<html>
<head>
    <style>
        body{
    font-family: 'Lato', sans-serif;
	position: relative;
	background:#ece6e6;
	margin: 20px;
}
.main-section{
    color:black;
}
</style>
</head>
<body bgcolor=#E6E6FA>
	<jsp:include page="header1.jsp" />
	<div class="main-section">
	<form>
		<table border='0' width='480px' cellpadding='0' cellspacing='0'
			align='center'>
			<center>
				<tr>
					<td><h1 align='center'>Delete Patient</h1></td>
				</tr>
				<center>

					<table border='0' width='480px' cellpadding='0' cellspacing='0'
						align='center'>
						<tr>
							<td align='left'>Patient SSN Id</td>
                            <td><input id="ssn-id" name='ssn-id' pattern="[0-9]{9}" required></td>
                            <td><button onclick="get()">Get</button></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align='left'>Patient Name</td>
							<td><input id="name" type='text' name='cname' pattern="[A-Za-z]+" required></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align='left'>Patient Age</td>
							<td><input id="age" name='age' min="1" max="3" pattern="[0-9]"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
                        </tr>
                        <tr>
							<td align='left'>Date of Admission</td>
							<td><input id="doj" type="date"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align='left'>Type of Bed</td>
							<td><select name="bed" id="bed">
									<option>Select</option>
									<option>General Ward</option>
									<option>Semi sharing</option>
									<option>Single room</option>
                                </select><br />
                                <br /></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
						<tr>
							<td align='left'>Address</td>
							<td><input name='addline' id="addr"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align='left'>City</td>
							<td><select name="city" id="city">
									<option>Select</option>
									<option>Pune</option>
									<option>Chennai</option>
									<option>Mumbai</option>
									<option>Raigad</option>
									<option>Nagpur</option>
									<option>Nasik</option>
									<option>Raigad</option>
									<option>Nagar</option>
									<option>Kolhapur</option>
									<option>Solapur</option>
							</select><br />
							<br /></td>

						</tr>

						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align='left'>State</td>
							<td><select name="state" id="state">
									<option>Select</option>
									<option>Arunachal Pradesh</option>
									<option>Assam</option>
									<option>Goa</option>
									<option>Manipur</option>
									<option>Maharashtra</option>
									<option>Karnataka</option>
									<option>Andhra Pradesh</option>
									<option>Telungana</option>
									<option>Tamil Nadu</option>
									<option>West Bengal</option>
							</select><br />
							<br /></td>

						</tr>

						<table border='0' cellpadding='0' cellspacing='0' width='480px'
							align='center'>
							<tr>
								<td align='center'><button onclick="register(event)">Delete</button></td>
								<td align='center'><button onclick="cancelEvent(event)">Cancel</button></td>

							</tr>

                        </table>
					</table>
		</table>
	</form>
	</div>
</body>
<script>
	function deletePatient() {
		window.location.href = "/searchpatient.jsp?action=delete";
	}
	function register(event) {
		event.preventDefault();
		if(confirm("Are you sure you want to delete?")){
			$.ajax({
				type : "delete",
				url : "/patient?" + "ssn-id=" + $("#ssn-ID").html(),
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
    function get()
{
    $.ajax({
				method : "get",
				url : "/patient",
				data : $('#search').serialize() + "&action=" + action,
				success : function(data) {
					var json = JSON.parse(data);
					var patient_details=[];
					patient_details=json["User_Details"];
					if(patient_details.length!=0){
						 if(action=="delete"){
							patient_details.forEach(user => {
								$("#ssnID").html(user["SSN_ID"]);
								$("#name").html(user["name"]);
								$("#age").html(user["age"]);
								$("#doj").html(user["DOA"]);
								$("#bed").html(user["type_of_bed"]);
								$("#addr").html(user["address"]);
								$("#city").html(user["city"]);
								$("#state").html(user["state"]);

							});
							$("#deletepatient").attr("class","");
							$("#searchpatient").attr("class","hide");	
						}
					}else{
						alert("No patient found with given ID !");
					}
				}
			});
		}
		function cancelEvent(event){
			event.preventDefault();
			$("#deletepatient").attr("class","hide");
			$("#updatepatient").attr("class","hide");
			$("#searchpatient").attr("class","");
		}</script>

</html>