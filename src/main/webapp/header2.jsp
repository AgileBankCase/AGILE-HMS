<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
ul {
    list-style-type: none;
  padding : 1px 20px;
  margin: 0;
  width: 100%;
  overflow: hidden;
  background-color: #333;
}
li {
  float: left;
}
li a, .dropbtn {
  display: inline-block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}
li a:hover, .dropdown:hover .dropbtn {
  background-color: red;
}
li.dropdown {
  display: inline-block;
}
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}
.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
}
.dropdown-content a:hover {background-color: #f1f1f1;}
.dropdown:hover .dropdown-content {
  display: block;
}
.hide{
  display:none;
}
.mainpage {
	margin-top: 2%;
	left: 50%;
	min-height: 70%;
}
.header{
  margin-top:0%;
  min-height: 20%;
  width: 100%;
  color:black;
}
</style>
</head>
<body bgcolor="#E6E6FA">
<div class="header">
<h1 align='center'>
	<strong>AGILE HOSPITAL MANAGEMENT</strong>
</h1>
<ul>
        <li><a href="/createpatient.jsp">Hello ${uname}!!!</a></li>
        <li><a href="/searchpatient.jsp">Patient Search</a></li>
        <li><a href="/issuemedicines.jsp">Issue Medicines</a></li>

        <li><a onclick="confirmLogout()" >Logout</a></li>
      </ul>
    </div>
</div>
<script>
function confirmLogout(){
	 if(confirm("Are you sure you want to log out?")){
		 document.location.href="/logout";	
	 }
}
</script>
</body>
</html>