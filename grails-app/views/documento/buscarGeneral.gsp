

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'documento.label', default: 'Documento')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>


        <div id="list-documento" class="content scaffold-list" role="main">
            <h1>Reporte de documentos por consulta general</h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:if test="${flash.error}">
                <div class="errors" role="status">${flash.error}</div>
            </g:if>
            <g:form method="post" >

  <!-- Div fechas -->
                <table border="0">


                    <tr>
                        <td style="width:100px">Fecha de inicio:</td>
                        <td style="width:350px"><g:datePicker id="fechaInicio" name="fechaInicio" precision="day" value="${params.fechaInicio}"  /></td>
                        <td>Fecha de fin:</td>
                        <td><g:datePicker id="fechaFin" name="fechaFin" precision="day" value="${params.fechaFin}"  /></td>
                    </tr>

                    <tr>
                        <td>Folio:</td>
                        <td>
                            <g:textField style="width: 200px" placeholder="- Folio -" name="folio" id="folio" value="${params.folio}"  />
                        </td>               
                        
                    </tr>

                    <tr>
                        <td>Remitente:</td>
                        <td>
                            <g:textField style="width: 350px" placeholder="- Remitente -" name="remitente" value="${params.remitente}"  />
                        </td>
                        
                        <td>Tipo de documento:</td>
                        <td>
                        <!--    <g:textField style="width: 200px" placeholder="- Tipo de documento -" name="tipoDocumento" value="${params.tipoDocumento}"  /> -->
                            <g:select id="tipoDocumento" name="tipoDocumento.id" from="${TipoDocumento.list(sort:"tipoDocumento", order:"asc")}" optionKey="id" value="${params?.tipoDocumento?.id} " noSelection="['0':'-Tipo Documento-']" class="many-to-one"/>

                        </td>
                        
                    </tr>                    

                    <tr>
                        <td>Asunto:</td>
                        <td>
                            <g:textField style="width: 350px" placeholder="- Asunto -" name="asunto" value="${params.asunto}"  />
                        </td>
                        <sec:ifAnyGranted roles="ROLE_DCCA">   
                        <td>Turnado Interno:</td>
                        <td>
                        <!--    <g:textField style="width: 200px" placeholder="- Tipo de documento -" name="tipoDocumento" value="${params.tipoDocumento}"  /> -->
                            <g:select id="turnadoInterno" name="turnadoInterno" from="${['Lic. Gustavo Martínez','Lic. Mariana Ugalde','C.P. María Josefina Cuevas','Interno','Pamela Ibet Pérez','Lic. Sergio González Lawers','Graciela Meyer']}" value="${params?.turnadoInterno}" noSelection="['':'-Seleccione-']" class="many-to-one"/>

                        </td>
                        </sec:ifAnyGranted>
                    </tr>



                </table>
                <fieldset class="buttons">
                    <g:actionSubmit class="save" action="consultaGeneral" value="Consultar" />
                    <g:actionSubmit class="excel" action="generarexcelconsulta" value="Generar Excel" /> 
                </fieldset>
            </g:form>

            <br>
            <div style="overflow: auto; "> 
            <table width="200px" >
                <thead>
                    <tr>



                        <th >Edit Doc.</th>

                        <th>Fecha Recibido</th>
                        
                        <th>Folio</th>
                        
                        <th>Remitente</th>

                        <th>Tipo Doc.</th>

                        <th>Asunto</th>
                        
                        <th>Prioridad</th>

                        <th>Status</th>

                    </tr>
                </thead>
                <tbody>
                    
                    
                    
                    <g:each in="${documentoInstanceList}" status="i" var="documentoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <g:hiddenField name="documentoID" value="${documentoInstance.id}" />

                            <td style="width:30%;"><g:link action="show" controller="documento" id="${documentoInstance.id}"><img src="../images/skin/editDocument.png" title="Mostrar Documento"></g:link></td>
                            <td> <div style="width:100px;"><g:formatDate format="dd-MM-yyyy" date="${documentoInstance.fechaRecibido}" /></div> </td>
                            <td> <div style="width:100px;"> ${fieldValue(bean: documentoInstance, field: "folio")} </div></td>                            
                            <td><div style="width:200px;"> ${fieldValue(bean: documentoInstance, field: "persona")} </div></td>
                            <td> ${fieldValue(bean: documentoInstance, field: "tipoDocumento")} </td>
                            <td ><div style="width:900px;"> ${fieldValue(bean: documentoInstance, field: "asunto")} </div></td>
                            <td>
                                <g:if test="${fieldValue(bean: documentoInstance, field: "prioridad")=="URGENTE"}">
                                    <font color="red"><b>${fieldValue(bean: documentoInstance, field: "prioridad")}</b></font>
                                    </g:if>
                                    <g:else>
                                        ${fieldValue(bean: documentoInstance, field: "prioridad")}
                                    </g:else>
                            </td>

                            

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
                                <g:elseif test="${documentoInstance.status==3}">

                                    <font color="green"><b>Concluido</b></font>

                                </g:elseif>
                                <g:else>
                                    Estatus desconocido
                                </g:else>
                            </td>

                        </tr>
                    </g:each>
                    
                </tbody>
            </table>
            
            </div>
            
            
            <div class="pagination">
                <g:if test="${documentoInstanceList}">
                    <g:paginate controller="documento" action="consultaGeneral" params="['paginacion':'si','fechaInicio':params.fechaInicio2 ,'fechaFin':params.fechaFin2, folio:params.folio, remitente:params.remitente, 'tipoDocumento.id':params.tipoDocumento.id, asunto:params.asunto]"  total="${documentoInstanceTotal}" />
                </g:if>
            </div>
        </div>
    </body>
</html>
