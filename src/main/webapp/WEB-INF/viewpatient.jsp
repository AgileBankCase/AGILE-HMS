<!DOCTYPE html>
<html>
<head>
    <style>

        .main-section{
	width: 460px;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}        
    </style>
</head>
<body bgcolor= #E6E6FA>
  <br>
    <br>
    <br>

 
<table border='0' width='480px' cellpadding='0' cellspacing='0' align='center'>
<center><tr>
   <td><h1 align='center'>View Patients</h1></td>
</tr><center>
    <table border="1"cellpadding='0' cellspacing='0' width='480px' align='center' id="view_patients">
    <tr>
      <th>Patient ID</th>
      <th>Name</th>
      <th>Age</th>
      <th>Address</th>
      <th>DOJ</th>
      <th>Type of BED</th>
    </tr>
  </table>
  <tr> <td>&nbsp;</td> </tr>
  <tr> <td>&nbsp;</td> </tr>
  </body>
    <script>
      $(document).ready(function(){
       $.getJSON("patient.json",function(data){
         var patient_data = '';
         $.each(data,function(key,value){
          patient_data += '<tr>';
            patient_data += '<td>'+value.patId+'</td>';
            patient_data += '<td>'+value.name+'</td>';
            patient_data += '<td>'+value.age+'</td>';
            patient_data += '<td>'+value.address+'</td>';
            patient_data += '<td>'+value.DOA+'</td>';
            patient_data += '<td>'+value.bed+'</td>';
            patient_data += '</tr>';
       });
       $('#view_patients').append(patient_data);
       });
      });
    </script>
             
          
  </html>
