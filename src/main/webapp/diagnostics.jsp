<!DOCTYPE html>
<html>
<head>
    <style>
body{
background:#ece6e6
}
        .main-section{
	width: 460px;
	position: relative;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
    color:black
}   
.diagnostics{
    width: 460px;
	position: relative;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
    color:black
}     
.additional{
    width: 460px;
	position: relative;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
    color:black
}
    </style>
</head>
<body bgcolor= #E6E6FA>
    <jsp:include page="header3.jsp" />

 <div class="main-section">
     <br>     <br>     <br>     <br>
<center><h1 align='center'>Diagnostics</h1>
    <table border="1"cellpadding='0' cellspacing='0' width='480px' align='center' id="view_patients">
    <tr>
      <th>Patient ID</th>
      <th>Name</th>
      <th>Age</th>
      <th>Address</th>
      <th>DOJ</th>
      <th>Type of BED</th>
    </tr>
    <tr> <td><input id="pat-id" name='patId' pattern="[0-9]{9}" width='480px' required><button type = "submit" name = "learn" value = "myimage">
   <img src="https://img.icons8.com/ios/13/000000/search--v1.png"/>
</button></td>
</tr>
  </table>
</div>
  <tr> <td>&nbsp;</td> </tr>
  <tr> <td>&nbsp;</td> </tr>
  <div class="diagnostics">
  <center><h1 align='center'>Diagnostics conducted</h1>
    <table border="1"cellpadding='0' cellspacing='0' width='320px' align='center' id="">
    <tr>
      <th>Name of the test</th>
      <th>Amount</th>
    </tr>
  </table>
  <br>
  <br>
  <button onclick="Adddiagnostics()" name="add diagnostics" align='center'>Add diagnostics</button>
</div>
<div class="additional">
      <table border="1"cellpadding='0' cellspacing='0' width='320px' align='center' id="">
      <tr>
        <th>Name of the test</th>
        <th>Amount</th>
      </tr>
    </table>
    <br>
    <br>
<center> <button onclick="add()" name="add" align='center'>ADD</button>
  </div>
  
  </body>
</html>