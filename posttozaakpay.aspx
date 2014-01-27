<%@ Page Language="C#" AutoEventWireup="true" CodeFile="posttozaakpay.aspx.cs" Inherits="posttozaakpay" %>
    <%@ Import Namespace = "System.IO" %>
   
    
    <%  
        //Please enter your secret key here  
        String secretKey = "";
            String allParamValue = null;
      
            allParamValue = Checksum.ChecksumCalculator.getAllNotEmptyParamValue(Request).Trim();
            String checksum = Checksum.ChecksumCalculator.calculateChecksum(secretKey, allParamValue);
	System.Diagnostics.Debug.WriteLine("allParamValue : " + allParamValue);
        System.Diagnostics.Debug.WriteLine("secretKey : " + secretKey);
    %>
       
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Zaakpay</title>
<link href="../stylesheets/styles-payflow.css" rel="stylesheet" type="text/css" />

 <link href="../javascripts/txnpage/sort.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../javascripts/txnpage/sort_files/jquery.js"></script>
		<script type="text/javascript" src="../javascripts/txnpage/sort_files/interface.js"></script>
        <script type="text/javascript">
            function submitForm() {
                var form = document.forms[0];
                form.submit();
            }
</script>
   
   </head>
   
   <body onload="javascript:submitForm()">
<center>
<table width="500px;">
	<tr>
		<td align="center" valign="middle">Do Not Refresh or Press Back <br/> Redirecting to Zaakpay</td>
	</tr>
	<tr>
		<td align="center" valign="middle">
			<form action="https://api.zaakpay.com/transact" method="post">
           
           
            <%
              
            
            IEnumerator postParams = Request.Form.GetEnumerator();
            while (postParams.MoveNext())
            {
                String param = (String)postParams.Current;
                /*String paramValue = Request.Params.Get(param);
                String path = @"d:\\Test.txt";
                FileStream fs1 = new FileStream(path, FileMode.Append, FileAccess.Write);
                StreamWriter sw1 = new StreamWriter(fs1);
                sw1.WriteLine(Checksum.ParamSanitizer.sanitizeParam(paramValue));
                sw1.Close();
                fs1.Close();*/
                if (param.Equals("returnUrl"))
                {
            %>        
            <input type="hidden" name="<%=param %>" value="<%=Checksum.ParamSanitizer.SanitizeURLParam(Request.Params.Get(param))%>" />
            <%}
                else
                {
             %>
             
            <input type="hidden" name="<%=param %>" value="<%=Checksum.ParamSanitizer.sanitizeParam(Request.Params.Get(param))%>" />
            <%    
                }
                          
            }
          
		    %>
            <input type="hidden" name="checksum" value="<%=checksum%>"/>
       
			
			</form>
		</td>

	</tr>

</table>

</center>	
</body>
</html>
