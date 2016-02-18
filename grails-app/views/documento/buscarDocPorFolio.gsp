

<!DOCTYPE html>
<html>
    <head>
        
        
        <g:javascript>   
$('#folio').keyup(function() {
    var tamano = document.getElementById('folio').value;
    var t = tamano.length
    var intValue = parseInt(t);
    if(intValue >= 2){

    $.ajax({
    url: '/SGC/documento/buscarFolioAjax/',  
    method: 'GET',
    data:{id:document.getElementById('folio').value},
    success: function(objeto){             


    /**/
    if (objeto) {
    var rselect = document.getElementById('id_Documento')
   
    // Clear all previous options 
    var l = rselect.length
    while (l > 0) {
    l-- 
    rselect.remove(l) 
    }

    // Rebuild the select 
    for (var i=0; i < objeto.length; i++) { 
    var cliente = objeto[i] 
    var opt = new Option(); 
    opt.text = cliente.id+"****"+cliente.folio 
    opt.value = cliente.id 
    try { 
    rselect.add(opt, null) 
    // standards compliant; doesn't work in IE 
    } catch(ex) { 
    rselect.add(opt) // IE only 
    } 
    } 
    }
    /**/

    },
    failure: function(){}
    });

    }else{

    }

    });

</g:javascript>
        
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'documento.label', default: 'Documento')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-documento" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-documento" class="content scaffold-list" role="main">
            <h1>Buscar Documentos por Folio</h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:if test="${flash.error}">
  <div class="errors" role="status">${flash.error}</div>
</g:if>
            <g:form method="post" >

  <!-- Div fechas -->
  <table>
      <tr>
      <div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'documentos', 'error')} ">
        <label for="persona">
          <g:message code="documento.persona.label" default="Folio" />

        </label>
        <g:textField name="folio" id="folio"  maxlength="210" value="" onkeyup="" size="20px"/>
  
  
  </div>
  
  
  
  
  <div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'documentos', 'error')} ">
        <label for="persona">
          <g:message code="documento.label" default="Documentos" />

        </label>
        <g:select id="id_Documento" name="documento.id" from="" multiple="multiple" optionKey="id" size="5" value="${documentoInstance?.id}" onclick="document.location.href='show/'+this.value" class="many-to-many" style=" width: 450px"/>
  
  </div>
    </tr>
      
    
</g:form>
        <br>
        </div>
    </body>
</html>
