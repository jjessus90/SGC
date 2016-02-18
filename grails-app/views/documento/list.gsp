<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'documento.label', default: 'Documento')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>


        <div id="list-documento" class="content scaffold-list" role="main">
            <h1>Bandeja de documentos</h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table>
                <thead>
                    <tr>

                        <th>Turnado</th>

                        <th>Edit Doc.</th>

                        <th>Seguimiento</th>

                        <th>Folio</th>

                        <th>Remitente</th>

                        <th>Prioridad</th>

                        <th>Dias de Holgura</th>

                        <th>Status</th>
                      
                        <th>Terminado</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${documentoInstanceList}" status="i" var="documentoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <g:hiddenField name="documentoID" value="${documentoInstance.id}" />

                            <td><g:link action="agregarDependenciasNombre" controller="turnado" id="${documentoInstance.id}"><img src="../images/skin/edit.png" title="Click para ver turnado"></g:link></td>

                            <td><g:link action="show" controller="documento" id="${documentoInstance.id}"><img src="../images/skin/editDocument.png" title="Mostrar Documento"></g:link></td>

                            <td><g:link action="agregarSeguimiento" controller="seguimiento" id="${documentoInstance.id}"><img src="../images/skin/editSeguimiento.png" title="Click para ver seguimiento"></g:link></td>

                            <td><b>${fieldValue(bean: documentoInstance, field: "folio")}</b></td>

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

                            <td>  <!-- celda de columna dias de holgura  -->
                           
                                   <!-- si el documento aun no tiene seguimiento, muestra las horas de holgura  -->
                                   <g:if test="${documentoInstance.status==0 || documentoInstance.status==1 }">  
                                        <g:if test="${8<listaHolgura[i]}">  
                                          <!--   <font color="red"><b>El documento tiene retraso de ${listaHolgura[i]-8} dias</b></font>  -->    
                                                <font color="red"><b>Retraso por ${listaHolgura[i]-8} dias</b></font>
                                        </g:if>                    
                                              <g:else>  ${listaHolgura[i]} </g:else>
                                   </g:if>
    
                                  <!-- cuando el documento tenga seguimiento o este terminado no muestra dias de holgura  -->
                                   <g:if test="${documentoInstance.status==2 || documentoInstance.status==3 }">
                                   
                                      <!--  <font color="yellow"><b>Listo</b></font> -->
                                  </g:if>
    
                            </td>

                            <td>  <!-- columna de status  -->
                                <g:if test="${documentoInstance.status==0}">    
                                    <font color="#000000"><b>Creado</b></font>
                                </g:if>
                                <g:elseif test="${documentoInstance.status==1}">

                                    <font color="blue"><b>Turnado</b></font>

                                </g:elseif>
                                <g:elseif test="${documentoInstance.status==2}">

                                    <font color="green"><b>Con seguimiento</b></font>

                                </g:elseif>
                                 
    
                               <g:elseif test="${documentoInstance.status==3}">

                                    <font color="gray"><b> Terminado</b></font>

                                </g:elseif>   
                               
                                  
    
    
                                <g:else>
                                    Estatus desconocido
                                </g:else>
                            </td>
                         
                             
                             <td> <!-- se genera el boton terminado es ta celda -->
                           <!--  <g:link action="documentTerminado" controller="documento" id="${documentoInstance.id}">Terminar</g:link>-->
                           
                          <!-- onclick="return confirm('${message(code: '¿Está seguro que desea quitar este seguimiento?', default: '¿Está seguro que desea quitar este seguimiento?')}');"    -->     
    
    
     
                    
                              
     <g:link action="documentTerminado" controller="documento" id="${documentoInstance.id}" onclick="return confirm('${message(code: '¿Está seguro que desea terminar el documeento?', default: '¿Está seguro que desea terminar el documento?')}');" >Terminar</g:link>
    
                             </td>
                           
                        
                        </tr>
                    </g:each>
                </tbody>
               
            </table>
            <div class="pagination">
                <g:paginate total="${documentoInstanceTotal}" controller="documento" action="list"/>
            </div>
        </div>
    </body>
</html>