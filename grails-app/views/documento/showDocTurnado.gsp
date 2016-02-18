

<!DOCTYPE html>
<html>
    <head>


        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'documento.label', default: 'Documento')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>

        <script>
            $(function() {
            $( "#tabs" ).tabs();
            });
        </script>

    </head>
    <body>
        <a href="#show-documento" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="show-documento" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <ol class="property-list documento">

                <g:if test="${documentoInstance?.folio}">
                    <li class="fieldcontain">
                        <span id="folio-label" class="property-label"><g:message code="documento.folio.label" default="Folio" /></span>

                        <b><h3><span class="property-value" aria-labelledby="folio-label"><g:fieldValue bean="${documentoInstance}" field="folio"/></span>
                            </h3></b>
                    </li>
                </g:if>


                <g:if test="${documentoInstance?.persona}">
                    <li class="fieldcontain">
                        <span id="persona-label" class="property-label"><g:message code="documento.persona.label" default="Remitente" /></span>

                        <span class="property-value" aria-labelledby="persona-label">${documentoInstance?.persona?.encodeAsHTML()}</span>

                    </li>
                </g:if>

                <g:if test="${documentoInstance?.tipoDocumento}">
                    <li class="fieldcontain">
                        <span id="tipoDocumento-label" class="property-label"><g:message code="documento.tipoDocumento.label" default="Tipo Documento" /></span>

                        <span class="property-value" aria-labelledby="tipoDocumento-label">${documentoInstance?.tipoDocumento?.encodeAsHTML()}</span>

                    </li>
                </g:if>

                <g:if test="${documentoInstance?.municipio}">
                    <li class="fieldcontain">
                        <span id="municipio-label" class="property-label"><g:message code="documento.municipio.label" default="Municipio" /></span>

                        <span class="property-value" aria-labelledby="municipio-label">${documentoInstance?.municipio?.encodeAsHTML()}</span>

                    </li>
                </g:if>

                <g:if test="${documentoInstance?.fechaCaptura}">
                    <li class="fieldcontain">
                        <span id="fechaCaptura-label" class="property-label"><g:message code="documento.fechaCaptura.label" default="Fecha Captura" /></span>

                        <span class="property-value" aria-labelledby="fechaCaptura-label"><g:formatDate date="${documentoInstance?.fechaCaptura}" format="dd-MMM-yyyy" /></span>

                    </li>
                </g:if>

                <g:if test="${documentoInstance?.fechaRecibido}">
                    <li class="fieldcontain">
                        <span id="fechaRecibido-label" class="property-label"><g:message code="documento.fechaRecibido.label" default="Fecha Recibido" /></span>

                        <span class="property-value" aria-labelledby="fechaRecibido-label"><g:formatDate date="${documentoInstance?.fechaRecibido}" format="dd-MMM-yyyy" /></span>

                    </li>
                </g:if>

                <g:if test="${documentoInstance?.prioridad}">
                    <li class="fieldcontain">
                        <span id="prioridad-label" class="property-label"><g:message code="documento.prioridad.label" default="Prioridad" /></span>

                        <span class="property-value" aria-labelledby="prioridad-label"><g:fieldValue bean="${documentoInstance}" field="prioridad"/></span>

                    </li>
                </g:if>

                <g:if test="${documentoInstance?.asunto}">
                    <li class="fieldcontain">
                        <span id="asunto-label" class="property-label"><g:message code="documento.asunto.label" default="Asunto" /></span>

                        <span class="property-value" aria-labelledby="asunto-label"><g:fieldValue bean="${documentoInstance}" field="asunto"/></span>

                    </li>
                </g:if>

                <g:if test="${documentoInstance?.status}">
                    <li class="fieldcontain">
                        <span id="status-label" class="property-label"><g:message code="documento.status.label" default="Status" /></span>


                        <g:if test="${documentoInstance?.status==0}">
                            <span class="property-value" aria-labelledby="status-label">Creado</span>
                        </g:if>
                        <g:elseif test="${documentoInstance?.status==1}">
                           <span class="property-value" aria-labelledby="status-label">Turnado</span> 
                        </g:elseif>
                        <g:elseif test="${documentoInstance?.status==2}">
                            <span class="property-value" aria-labelledby="status-label">Con Seguimiento</span>
                        </g:elseif>



                    </li>
                </g:if>

               
                <g:if test="${documentoInstance?.upload}">
                    <li class="fieldcontain">
                        <span id="nota-label" class="property-label"><g:message code="documento.nota.label" default="Escaneo" /></span>

                        <span class="property-value" aria-labelledby="nota-label"><g:link  action="downloadFile" id="${documentoInstance?.id}" params="['id': documentoInstance?.id, 'folio': documentoInstance?.folio]" title="Descargar Escaneo" controller="documento"> <img src="${resource(dir:'images/skin',file:'escaneo.png')}" width="" height="" />    </g:link></span>

                    </li>
                </g:if>
                <g:elseif test="${!documentoInstance?.upload}">
                    <li class="fieldcontain">
                    <span id="nota-label" class="property-label"><g:message code="documento.nota.label" default="Escaneo" /></span>
                    
                    <span class="property-value" aria-labelledby="asd-label">No existe archivo</span>
                    
                            </li>
                        </g:elseif>

                
                

            </ol>
            <g:form>
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${documentoInstance?.id}" />
                    
                    <g:link class="edit" action="agregarSeguimientoTurnado" controller="seguimiento" id="${documentoInstance?.id}">Agregar Seguimiento</g:link>
                    </fieldset>
            </g:form>

            <div id="tabs">
                <ul>
                    <li><a href="#tabs-1">Turnado a:</a></li>
                    <li><a href="#tabs-2">Seguimiento</a></li>
                    
                </ul>
                <div id="tabs-1">
                    <p>
                        <g:if test="${turnadoInstance}">
                            <br>

                        <table style=" font-size: 13px;">
                            <thead>
                                <tr>

                                    <th>No.</th>

                                    <th>Dependencia</th>
                                    <th>Persona</th>
                                    <th>Responsabilidad</th>

                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${turnadoInstance}" status="i" var="turnado">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">


                                        <td>${i + 1} </td>

                                        <td>${turnadoInstance[i]?.dependencia?.nombre?.encodeAsHTML()}</td>
                                        
                                        <td>${turnadoInstance[i]?.persona?.nombre?.encodeAsHTML()}</td>
                                        <td>${turnadoInstance[i]?.responsabilidad?.encodeAsHTML()}</td>

                                    </tr>
                                </g:each>
                            </tbody>

                        </table>
                        
                         <!--<h5>Reporte de turnado</h5>
                            <g:jasperReport jasper="turnado" format="PDF, PPTX" name="" action="turnadoPDF" controller="reporte">

                                <g:hiddenField name="idDoc" value="${documentoInstance?.id}"/>
                                <g:hiddenField name="folio" value="${documentoInstance?.folio}"/>
                                <g:hiddenField name="remitente" value="${documentoInstance?.persona?.nombre}"/>
                                <g:hiddenField name="fechaRecibido" value="${documentoInstance?.fechaRecibido}"/>
                                <g:hiddenField name="asunto" value="${documentoInstance?.asunto}"/>
                                
                                
                            </g:jasperReport>-->
                    </g:if>
                    </p>
                </div>
                <div id="tabs-2">
                    <p>
                        <g:if test="${seguimientoInstance}">

                        <table style=" font-size: 13px;">
                            <thead>
                                <tr>

                                    <th>No.</th>
                                    <th>Seguimiento</th>
                                    <th>Fecha Captura</th>

                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${seguimientoInstance}" status="i" var="seguimiento">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">


                                        <td>${i + 1}</td>

                                        <td>${seguimientoInstance[i]?.seguimiento?.encodeAsHTML()}</td>

                                        <td>
                                            <g:formatDate date="${seguimientoInstance[i]?.fechaCaptura}" format="dd-MMM-yyyy" />
                                        </td>

                                    </tr>
                                </g:each>
                            </tbody>

                        </table>


                    </g:if>
                    </p>
                </div>

            </div>







        </div>
    </body>
</html>
