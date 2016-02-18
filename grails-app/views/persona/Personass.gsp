<!DOCTYPE html>
<html>
    <head>
        
        
        
        <g:javascript>   
$('#nombreRemitente').keyup(function() {
    var tamano = document.getElementById('nombreRemitente').value;
    var t = tamano.length
    var intValue = parseInt(t);
    if(intValue >= 2){

    $.ajax({
    url: '<%=request.getContextPath()%>'+'/documento/buscadorAjax/',  
    method: 'GET',
    data:{id:document.getElementById('nombreRemitente').value},
    success: function(objeto){             


    /**/
    if (objeto) {
    var rselect = document.getElementById('id_Remitente')
   
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
    opt.text = "  "+cliente.nombre 
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
        
        <g:hiddenField name="personaa" value="${person}" />
        
        <a href="#list-documento" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-documento" class="content scaffold-list" role="main">
            <h1>Buscar Persona</h1>
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
          <g:message code="documento.persona.label" default="Nombre" />

        </label>
        <g:textField name="nombreRemitente" id="nombreRemitente"  maxlength="210" value="" onkeyup="" size="20px"/>
  
  
  </div>
  
  
  
  
  <div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'documentos', 'error')} ">
           <label for="persona">
   
          </label>
        <g:select id="id_Remitente" name="persona.id" from="" required="true" multiple="multiple" optionKey="id" size="5" value="${documentoInstance?.persona*.id}" class="many-to-many" style=" width: 450px"/>
  
  </div>
    </tr>
      
  </table> 
  <fieldset class="buttons">
    <g:actionSubmit class="save" action="consultaPorPersona" value="Consultar" />
  </fieldset>
  
  
</g:form>
      
            
            <table>
                <thead>
		  <tr>
					
		    <g:sortableColumn property="nombre" title="${message(code: 'persona.nombre.label', default: 'Nombre')}" />
					
		    <g:sortableColumn property="correo" title="${message(code: 'persona.correo.label', default: 'Correo')}" />
					
		    <g:sortableColumn property="calleNumero" title="${message(code: 'persona.calleNumero.label', default: 'Calle Numero')}" />
					
		    <g:sortableColumn property="cargo" title="${message(code: 'persona.cargo.label', default: 'Cargo')}" />
					
		    <g:sortableColumn property="colonia" title="${message(code: 'persona.colonia.label', default: 'Colonia')}" />
					
		    <g:sortableColumn property="cp" title="${message(code: 'persona.cp.label', default: 'Cp')}" />
					
		 </tr>
	       </thead>
               <tbody>
                   <g:each in="${personaInstanceList}" status="i" var="personaInstance">
                   <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" >
                      
                   <td><g:link action="show" id="${personaInstance.id}">${fieldValue(bean: personaInstance, field: "nombre")}</g:link></td>
		   <td>${fieldValue(bean: personaInstance, field: "correo")}</td>
		   <td>${fieldValue(bean: personaInstance, field: "calleNumero")}</td>
		   <td>${fieldValue(bean: personaInstance, field: "cargo")}</td>
		   <td>${fieldValue(bean: personaInstance, field: "colonia")}</td>
		   <td>${fieldValue(bean: personaInstance, field: "cp")}</td>
                   
                   </tr>
                   </g:each>
                   
               </tbody>
                
                
               
            </table>
            <div class="pagination">
           
            </div>
            
        </div>
    </body>
</html>