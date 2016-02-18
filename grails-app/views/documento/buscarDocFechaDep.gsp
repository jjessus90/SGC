

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'documento.label', default: 'Documento')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-documento" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-documento" class="content scaffold-list" role="main">
            <h1>Buscar Documentos</h1>
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
                        <td>Fecha de inicio:</td>
                        <td><g:datePicker name="fechaInicio" precision="day" value="${fechaInicio}"  /></td>
                    </tr>
                    <tr>
                        <td>Fecha de fin:</td>
                        <td><g:datePicker name="fechaFin" precision="day" value="${fechaFin}"  /></td>
                    </tr> 

                </table>
                <fieldset class="buttons">
                    <g:actionSubmit class="save" action="consultaDocFechaDep" value="Consultar" />
                </fieldset>
            </g:form>

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

            <br>
            <table>
                <thead>
                    <tr>

                       

                        <th>Documento</th>

                        <th>Folio</th>

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

                            <td><g:link action="showDocTurnado" controller="documento" id="${documentoInstance.id}"><img src="../images/skin/editDocument.png" title="Mostrar Documento"></g:link></td>

                            <td>${fieldValue(bean: documentoInstance, field: "folio")}</td>
                            
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
                <g:paginate total="${documentoInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
