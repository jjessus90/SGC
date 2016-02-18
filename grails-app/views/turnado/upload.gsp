<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sample title</title>
    </head>
    <body>
        
        Upload Form: <br />
    <g:uploadForm action="uploadFile" enctype="multipart/form-data">
        <input type="file" name="myFile" />
        <input type="submit" />
    </g:uploadForm>
        <g:link  action="downloadFile" id="${documentoInstance?.id}" params="['id': documentoInstance?.id]" title="Click mostrar detalle general del documento" controller="turnado"> <img src="${resource(dir:'images/skin',file:'escaneo.png')}" width="" height="" />    </g:link>
    </body>
</html>
