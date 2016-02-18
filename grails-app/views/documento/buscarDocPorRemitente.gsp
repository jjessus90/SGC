

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
    opt.text = cliente.id+" "+cliente.nombre 
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
            <h1>Buscar Documentos por Remitente</h1>
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
          <g:message code="documento.persona.label" default="Remitentes" />

        </label>
        <g:select id="id_Remitente" name="persona.id" from="" required="true" multiple="multiple" optionKey="id" size="5" value="${documentoInstance?.persona*.id}" class="many-to-many" style=" width: 450px"/>
  
  </div>
    </tr>
      
    <tr>
      <td>Fecha de inicio:</td>
      <td><g:datePicker name="fechaInicio" precision="day" value="${fechaInicio}"  /></td>
    </tr>
    <tr>
      <td>Fecha de fin:</td>
      <td><g:datePicker name="fechaFin" precision="day" value="${fechaFin}"  /></td>
    </tr> 

  </table>
  <fieldset class="buttons">
    <g:actionSubmit class="save" action="consultaDocPorRemitente" value="Consultar" />
  </fieldset>
</g:form>
        
        <g:if test="${nombreRemitente}">
  <li class="fieldcontain">
    <span id="fechaSolicitud-label" class="property-label"><g:message code="documento.fechaCaptura.label" default="Persona:" /></span>

    <span class="property-value" ><b>${nombreRemitente}</b></span>

  </li>
</g:if>
        <g:if test="${fechaInicio}">
  <li class="fieldcontain">
    <span id="fechaSolicitud-label" class="property-label"><g:message code="documento.fechaCaptura.label" default="Fecha Inicio" /></span>

    <span class="property-value" aria-labelledby="fechaCaptura-label"><g:formatDate date="${fechaInicio}" format="dd-MMM-yyyy" /></span>

  </li>
</g:if>
<g:if test="${fechaFin}">
  <li class="fieldcontain">
    <span id="fechaSolicitud-label" class="property-label"><g:message code="documento.fechaCaptura.label" default="Fecha Fin" /></span>

    <span class="property-value" aria-labelledby="fechaCaptura-label"><g:formatDate date="${fechaFin}" format="dd-MMM-yyyy" /></span>

  </li>
</g:if>
            
            <table>
                <thead>
                    <tr>

                       <th>Turnado</th>

                        <th>Edit Doc.</th>

                        <th>Seguimiento</th>

                        <th>Fecha</th>

                        <th>Remitente</th>

                        <th>Prioridad</th>

                        <th>Asunto</th>

                        <th>Status</th>

                    </tr>
                </thead>
                <tbody>
                    <g:each in="${documentoInstanceList}" status="i" var="documentoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <g:hiddenField name="documentoID" value="${documentoInstance.id}" />

                            <td><g:link action="agregarDependenciasNombre" controller="turnado" id="${documentoInstance.id}"><img src="../images/skin/edit.png" title="Click para ver turnado"></g:link></td>

                            <td><g:link action="show" controller="documento" id="${documentoInstance.id}"><img src="../images/skin/editDocument.png" title="Mostrar Documento"></g:link></td>

                            <td><g:link action="agregarSeguimiento" controller="seguimiento" id="${documentoInstance.id}"><img src="../images/skin/editSeguimiento.png" title="Click para ver seguimiento"></g:link></td>
                            
                            <td><g:formatDate date="${documentoInstance?.fechaCaptura}" format="dd-MMM-yyyy" /></td>

                            <td>
                                <g:if test="${documentoInstance.dependenciaRemitente}">
                                    ${fieldValue(bean: documentoInstance, field: "dependenciaRemitente")}
                                </g:if>
                                <g:if test="${documentoInstance.persona}">
                                    ${fieldValue(bean: documentoInstance, field: "persona")}
                                </g:if>
                                </td>   

                            <td>
                                <g:if test="${fieldValue(bean: documentoInstance, field: "prioridad")=="URGENTE"}">
                                    <font color="red"><b>${fieldValue(bean: documentoInstance, field: "prioridad")}</b></font>
                                    </g:if>
                                    <g:else>
                                        ${fieldValue(bean: documentoInstance, field: "prioridad")}
                                    </g:else>
                            </td>

                            <td>${fieldValue(bean: documentoInstance, field: "asunto")}</td>

                            <td>
                                <g:if test="${documentoInstance.status==0}">
                                    <font color="#000000"><b>Creado</b></font>
                                </g:if>
                                <g:elseif test="${documentoInstance.status==1}">
                                    
                                    <font color="blue"><b>Turnado</b></font>
                                    
                                </g:elseif>
                                    <g:elseif test="${documentoInstance.status==2}">
                                    
                                    <font color="green"><b>Con seguimiento</b></font>
                                    
                                </g:elseif>
                                <g:else>
                                    Estatus desconocido
                                </g:else>
                            </td>

                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination">
                <g:paginate total="${documentoInstanceTotal}"/>
            </div>
        </div>
    </body>
</html>
