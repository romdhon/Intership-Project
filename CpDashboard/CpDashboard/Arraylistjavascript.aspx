<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Arraylistjavascript.aspx.cs" Inherits="CpDashboard.Arraylistjavascript" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  
<head runat="server">  
  <title>Untitled Page</title>  
  
  <script language="javascript" type="text/javascript">  
      function Test() {  
          var listString = document.getElementById('HiddenField1').value;  
          var listArray = listString.split('~');  
  
          // Now you have an array in javascript of each value  
  
          for(var i = 0; i < listArray.length; i++) {  
              alert(listArray[i]);  
          }  
  
      }  
  </script>  
  
</head>  
<body>  
  <form id="form1" runat="server">  
      <div>  
          <asp:HiddenField ID="HiddenField11" runat="server" />  
          <input type="button" onclick="Test();" value="Get Value From ArrayList" />  
      </div>  
  </form>  
</body>  
</html>  
