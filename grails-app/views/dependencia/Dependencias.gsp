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
    url: '<%=request.getContextPath()%>'+'/dependencia/busquedaDependenciaAjax/',  
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
        
        <g:hiddenField name="dependenciaa" value="${depen}" />
        
        <a href="#list-documento" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-documento" class="content scaffold-list" role="main">
            
            <h1>Buscar Dependencia</h1>
            
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
      <div class="fieldcontain ${hasErrors(bean: dependenciaInstance, field: 'documentos', 'error')} ">
        <label for="persona">
          <g:message code="dependencia.persona.label" default="Nombre" />

        </label>
        <g:textField name="nombreRemitente" id="nombreRemitente"  maxlength="210" value="" onkeyup="" size="20px"/>
  
  
  </div>
  
  
  
  
  
  <div class="fieldcontain ${hasErrors(bean: dependenciaInstance, field: 'documentos', 'error')} ">
           <label for="persona">
   
          </label>
        <g:select id="id_Remitente" name="dependencia.id" from="" required="true" multiple="multiple" optionKey="id" size="5" value="${dependenciaInstance?.dependencia*.id}" class="many-to-many" style=" width: 450px"/>
  
  </div>
    </tr>
      
  </table> 
  <fieldset class="buttons">
    <g:actionSubmit class="save" action="consultaPorDependencia" value="Consultar" />
  </fieldset>
  
  
</g:form>
      
            
            <table>
              <theader>
                  <tr>
					
	         <g:sortableColumn property="nombre" title="${message(code: 'dependencia.nombre.label', default: 'Nombre')}" />
					
		 <g:sortableColumn property="calleNumero" title="${message(code: 'dependencia.calleNumero.label', default: 'Calle Numero')}" />
					
	         <g:sortableColumn property="status" title="${message(code: 'dependencia.status.label', default: 'Status')}" />
					
		 <th><g:message code="dependencia.estado.label" default="Estado" /></th>
					
		 <th><g:message code="dependencia.municipio.label" default="Municipio" /></th>
					
		<g:sortableColumn property="colonia" title="${message(code: 'dependencia.colonia.label', default: 'Colonia')}" />
					
		</tr>
              </theader>
               <tbody>
                  <g:each in="${dependenciaInstanceList}" status="i" var="dependenciaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${dependenciaInstance.id}">${fieldValue(bean: dependenciaInstance, field: "nombre")}</g:link></td>
					
						<td>${fieldValue(bean: dependenciaInstance, field: "calleNumero")}</td>
					
						<td><g:formatBoolean boolean="${dependenciaInstance.status}" /></td>
					
						<td>${fieldValue(bean: dependenciaInstance, field: "estado")}</td>
					
						<td>${fieldValue(bean: dependenciaInstance, field: "municipio")}</td>
					
						<td>${fieldValue(bean: dependenciaInstance, field: "colonia")}</td>
					
					</tr>
		</g:each>
               </tbody>
                
                
               
            </table>
            <div class="pagination">
           
            </div>
            
        </div>
    </body>
</html>