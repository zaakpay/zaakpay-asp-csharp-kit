<%@ Page Language="C#" AutoEventWireup="true" CodeFile="response.aspx.cs" Inherits="response" %>
    <%@ Import Namespace = "System.IO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Zaakpay</title>
<link href="../stylesheets/styles-payflow.css" rel="stylesheet" type="text/css" />

 <link href="../javascripts/txnpage/sort.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../javascripts/txnpage/sort_files/jquery.js"></script>
		<script type="text/javascript" src="../javascripts/txnpage/sort_files/interface.js"></script>
<!--this is use for remove captchasecton color or image-->

<!--popup_layer-->  


</head>
<body>


<% 
	
		String orderId = Request.Params.Get("orderId");
		String responseCode = Request.Params.Get("responseCode");
		String responseDescription = Request.Params.Get("responseDescription");
		String transactionId = Request.Params.Get("transactionId");
		String amount = Request.Params.Get("amount");
		String checksum = Request.Params.Get("checksum");	
		Boolean isChecksumValid = false;
   
		// Please insert your own secret key here
        String secretKey = "";
		
		String allParamValue = ("'"+orderId+"''"+responseCode+"''"+responseDescription+"'").Trim();
		if(checksum != null){
            isChecksumValid = ChecksumResponse.ChecksumCalculatorResponse.verifyChecksum(secretKey, allParamValue, checksum);
    
		}

        System.Diagnostics.Debug.WriteLine("allParamValue : " + allParamValue);
        System.Diagnostics.Debug.WriteLine("secretKey : " + secretKey);
	%>
    <center>
    
   <table>
   
   <tr>
        <td align = "center">OrderId</td>
        <td align = "center"><%=orderId%> </td>
  </tr>
  <tr>
        <td align = "center">Response Code</td>
        <%if (isChecksumValid)
          { %>
        <td align = "center"> <%=responseCode%></td>
        <%}
          else
          { %>
          <td align ="center"><font color ="red">***</font></td>
          <%} %>
  
  </tr>
   <tr>
        <td align = "center">Response Description</td>
        <%if (isChecksumValid)
          { %>
        <td align = "center"> <%=responseDescription%></td>
        <%}
          else
          { %>
          <td align ="center"><font color ="red">The Response is Compromised.</font></td>
          <%} %>
  
  </tr>

   <tr>
        <td align = "center">Checksum Valid</td>
        <%if (isChecksumValid)
          { %>
        <td align = "center">Yes</td>
        <%}
          else
          { %>
          <td align ="center"><font color ="red">No </font><br /><br />The Transaction might have been Successfull.</td>
          
          <%} %>
  
  </tr>
   
   
   </table>
   
    </center>
    
</body>
</html>

