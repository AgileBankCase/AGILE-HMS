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
			<tr>
				<td colspan='2'>
					<h1 align='center'>Update Patient</h1>
				</td>

			</tr>
			<tr>

				<td align='left'>Patient ID</td>
				<td><input id="Pid" name='patId' pattern="[0-9]{9}" required>
					<button onclick="getpatient(event)" name="learn" value="myimage">
						<img src="https://img.icons8.com/ios/13/000000/search--v1.png" />
					</button></td>

			</tr>
		</table>
		<form>
			<table id="updatepatient" border='0' width='480px' cellpadding='0'
				cellspacing='0' align='center' class="hide">
				<tr>
					<td align='left'>Patient SSN Id</td>
					<td><input id="ssnId" name='ssn-id' disabled='true'
						pattern="[0-9]{9}"> <input id="patId" name='patId'
						pattern="[0-9]{9}" type='hidden'></td>

				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td align='left'>Patient Name</td>
					<td><input id="name" type='text' name='name'
						pattern="[A-Za-z]+"></td>

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

					<td><input id="doa" type="date" name="doa"></td>

				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align='left'>Type of Bed</td>
					<td><select name="bed" id="bed">
							<option value="Select">Select</option>
							<option value="General Ward">General Ward</option>
							<option value="Semi sharing">Semi sharing</option>
							<option value="Single room">Single room</option>
					</select><br /> <br /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align='left'>Address</td>
					<td><input name='address' id="address"></td>

				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align='left'>City</td>
					<td><select name="city" id="city">
							<option value="Select">Select</option>
							<option value="Pune">Pune</option>
							<option value="Chennai">Chennai</option>
							<option value="Mumbai">Mumbai</option>
							<option value="Nagpur">Nagpur</option>
							<option value="Nasik">Nasik</option>
							<option value="Raigad">Raigad</option>

							<option value="Kolhapur">Kolhapur</option>
							<option value="Solapur">Solapur</option>
					</select></td>

				</tr>

				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td align='left'>State</td>
					<td><select name="state" id="state">
							<option value="Select">Select</option>
							<option value="Arunachal Pradesh">Arunachal Pradesh</option>
							<option value="Assam">Assam</option>
							<option value="Goa">Goa</option>
							<option value="Manipur">Manipur</option>
							<option value="Maharashtra">Maharashtra</option>
							<option value="Karnataka">Karnataka</option>
							<option value="Andhra Pradesh">Andhra Pradesh</option>
							<option value="Telungana">Telungana</option>
							<option value="Tamil Nadu">Tamil Nadu</option>
							<option value="West Bengal">West Bengal</option>
					</select><br /> <br /></td>

				</tr>


				<tr>
					<td align='center'><button onclick="register(event)">Update</button></td>

				</tr>
			</table>

		</form>
	</div>
</body>
<script>
	function register(event) {
		event.preventDefault();
		$.ajax({
			method : "put",
			url : "/patient?" + $('form').serialize(),
			success : function(data) {
				var json = JSON.parse(data);
				alert(json["status"]);
				if (json["status"] == "Succesfully Updated!") {
					document.location.reload();
				}
			}
		});
	}
	function getpatient(event) {
		event.preventDefault();
		$.ajax({
			method : "get",
			url : "/patient?patId=" + $("#Pid").val(),

			success : function(data) {
				var json = JSON.parse(data);
				var patient_details = [];
				patient_details = json["patient_details"];
				if (patient_details.length != 0) {
					var user = {};
					user = patient_details[0];
					$("#ssnId").val(user["SSN_ID"]);
					$("#patId").val(user["patient_ID"]);
					$("#name").val(user["name"]);
					$("#age").val(user["age"]);
					$("#doa").val(user["DOA"]);
					$("#bed").val(user["type_of_bed"]);
					$("#address").val(user["address"]);
					$("#city").val(user["city"]);
					console.log(user["city"] + user["state"]);
					$("#state").val(user["state"]);
					$("#updatepatient").attr("class", "");
				} else {
					alert("No patient found with given ID !");
				}
			}
		});
	}
</script>

</html>