<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
    <style>
        body{
    font-family: 'Lato', sans-serif;
	position: relative;
	background:cadeblue;
	margin: 20px;
}
.header{
	font-family: 'Lato', sans-serif;
	position: relative;
    color:black;
}
.main-section{
	width: 460px;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
.content-section{
	background: #FFF;
	border-radius: 2px;
	box-shadow: 0px 0px 0px 8px rgba(0,0,0,0.1);
}
.head-section{
	background: #F3F3F3;
	text-align: center;
	padding: 15px 0px;
	border-bottom: 1px solid #CECECE;
}
.head-section h3{
	margin: 0px;
	color: #565656;
}
.body-section{
	padding:15px 30px 30px 30px;
	overflow: hidden;
}
.body-section .form-input{
	width: 100%;
	padding: 15px 0px;
}
.body-section .form-input input[type='text']{
	width: calc(100% - 30px);
	border: 1px solid #D3D3D3;
	border-radius: 1px;
	padding:10px 10px;
	box-shadow: 0px 0px 0px 5px rgb(239,244,247);
}
.body-section .form-input input[type='password']{
	width: calc(100% - 30px);
	border: 1px solid #D3D3D3;
	border-radius: 1px;
	padding:10px 10px;
	box-shadow: 0px 0px 0px 5px rgb(239,244,247);
}
.body-section .form-input input[type='checkbox']{
	float: left;
}
.body-section label{
	color: #565656;
	padding: 1px 5px;
	float: left;
}
.body-section .btn-submit{
	float: right;
	background: #DEEDF4;
	border:1px solid #B5CBCD;
	color: #56778E;
	font-weight: bold;
	padding:7px 20px;
	border-radius: 15px;
}
    </style>
</head>
<body>
	<div class="header">
		<h1 align='center'>
			<strong>AGILE HOSPITAL MANAGEMENT</strong>
	</h1>
	</div>	
	<div class="main-section">
		<div class="content-section">
			<div class="head-section">
				<h3>Login</h3>
			</div>
			<div class="body-section">
				<form action="/login" method="post">
					<div class="form-input">
						<input type="text" name="username" placeholder="Username or Email">
					</div>
					<div class="form-input">
						<input type="password" name="password" placeholder="Password">
					</div>
					<div class="form-input">
						<input type="checkbox" name=""> <label>Remember me</label>
						<button type="submit" class="btn-submit">Login</button>
					</div>
				</form>
			</div>
		</div>
		
	</div>
</body>
</html>