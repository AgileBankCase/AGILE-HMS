<!DOCTYPE html>
<html>
<head>
    <style>
        body{
    font-family: 'Lato', sans-serif;
	position: relative;
	background: #ece6e6;
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
					<td><h1 align='center'>Patient Registration</h1></td>
				</tr>
				<center>

					<table border='0' width='480px' cellpadding='0' cellspacing='0'
						align='center'>
						<tr>
							<td align='left'>Patient SSN Id</td>
							<td><input name='ssnId' pattern="[0-9]{9}" required></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align='left'>Patient Name</td>
							<td><input type='text' name='name' pattern="[A-Za-z]+" required></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align='left'>Patient Age</td>
							<td><input name='age' min="1" max="3" pattern="[0-9]"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
                        </tr>
                        <tr>
							<td align='left'>Date of Admission</td>
							<td><input type="date" name="DOA"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align='left'>Type of Bed</td>
							<td><select name="bed">
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
							<td><input name='address'></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td align='left'>City</td>
							<td><select name="city">
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
							<td><select name="state">
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
								<td align='center'><button onclick="register(event)">Submit</button></td>
								<td><button>Reset</button></td>
							</tr>

                        </table>
					</table>
		</table>
	</form>
	</div>
</body>
<script>
	function updatePatient() {
		window.location.href = "/searchpatient.jsp?action=update";
	}
	function register(event) {
		event.preventDefault();
		$.ajax({
			method : "post",
			url : "/patient",
			data : $('form').serialize(),
			success : function(data) {
				var json = JSON.parse(data);
				alert(json["status"]);
				if (json["status"] == "Succesfully Registered!") {
					document.location.reload();
				}
			}
		});
	}
</script>

</html>