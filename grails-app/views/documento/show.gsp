

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
        <g:javascript> 
 /*Carga Dependencias*/

    function cargaDependencias(){
        $.ajax({
            url: '/SGC/ClasificacionArchivo/ajaxGetDependencias/',  
            method: 'GET',
            data:{id:document.getElementById('tipoDependencia').value},
            success: function(objeto){             
        /**/
            if (objeto) {
                var rselect = document.getElementById('clasificacion')

                // Clear all previous options 
                var l = rselect.length
                while (l > 0) {
                    l-- 
                    rselect.remove(l) 
                }

                if(1 > objeto.length){
                    alert('No hay dependencias registrados para esta clasificación')
                }

                var opt = new Option(); 
                opt.text = 'Seleccione...';
                opt.value ="";

                    try { 
                        rselect.add(opt, null) 
                        // standards compliant; doesn't work in IE 
                    } catch(ex) {   
                        rselect.add(opt) // IE only 
                    }


                    // Rebuild the select 
                    for (var i=0; i < objeto.length; i++) {   
                        var producto = objeto[i]; 
                        var opt = new Option(); 

                        opt.text = producto.dependencia;
                        opt.value = producto.id;

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
    failure: function(){

    }
    });

    }

</g:javascript>
    </head>
    <body>
    
        <a href="#show-documento" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="show-documento" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:if test="${flash.error}">
                <div class="message" role="status">${flash.error}</div>
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
                <g:if test="${documentoInstance?.dependenciaRemitente}">
                    <li class="fieldcontain">
                        <span id="persona-label" class="property-label"><g:message code="documento.persona.label" default="Remitente" /></span>

                        <span class="property-value" aria-labelledby="persona-label">${documentoInstance?.dependenciaRemitente?.encodeAsHTML()}</span>

                    </li>
                </g:if>

                <g:if test="${documentoInstance?.presente}">
                    <li class="fieldcontain">
                        <span id="presente-label" class="property-label"><g:message code="documento.folio.label" default="Presente" /></span>

                        <span class="property-value" aria-labelledby="presente-label"><g:fieldValue bean="${documentoInstance}" field="presente"/></span>

                    </li>
                </g:if>
                <g:if test="${documentoInstance?.dirigido}">
                    <li class="fieldcontain">
                        <span id="presente-label" class="property-label"><g:message code="documento.dirigido.label" default="Dirigido a:" /></span>

                        <span class="property-value" aria-labelledby="dirigido-label"><g:fieldValue bean="${documentoInstance}" field="dirigido"/></span>

                    </li>
                </g:if>
                <g:if test="${documentoInstance?.turnadoInterno}">
                    <li class="fieldcontain">
                        <span id="presente-label" class="property-label"><g:message code="documento.TurnadoInterno.label" default="Turnado Interno" /></span>

                        <span class="property-value" aria-labelledby="turnadoInterno-label"><g:fieldValue bean="${documentoInstance}" field="turnadoInterno"/></span>

                    </li>
                </g:if>
                <g:if test="${documentoInstance?.tipoDocumento}">
                    <li class="fieldcontain">
                        <span id="tipoDocumento-label" class="property-label"><g:message code="documento.tipoDocumento.label" default="Tipo Documento" /></span>

                        <span class="property-value" aria-labelledby="tipoDocumento-label">${documentoInstance?.tipoDocumento?.encodeAsHTML()}</span>

                    </li>
                </g:if>
                <g:if test="${documentoInstance?.indicacion}">
                    <li class="fieldcontain">
                        <span id="tipoDocumento-label" class="property-label"><g:message code="documento.indicacion.label" default="Indicación" /></span>

                        <span class="property-value" aria-labelledby="indicacion-label">${documentoInstance?.indicacion?.encodeAsHTML()}</span>

                    </li>
                </g:if>
                <g:if test="${documentoInstance?.indicacionTexto}">
                    <li class="fieldcontain">
                        <span id="indicacionTexto-label" class="property-label"><g:message code="documento.indicacionTexto.label" default="Indicación Modificada" /></span>

                        <span class="property-value" aria-labelledby="indicacionTexto-label"><g:fieldValue bean="${documentoInstance}" field="indicacionTexto"/></span>

                    </li>
                </g:if>
                <g:if test="${documentoInstance?.observacion}">
                    <li class="fieldcontain">
                        <span id="observacion-label" class="property-label"><g:message code="documento.observacion.label" default="Observación" /></span>

                        <span class="property-value" aria-labelledby="observacion-label"><g:fieldValue bean="${documentoInstance}" field="observacion"/></span>

                    </li>
                </g:if>
                 <g:if test="${documentoInstance?.signatario}">
                    <li class="fieldcontain">
                        <span id="signatario-label" class="property-label"><g:message code="documento.signtarario.label" default="Signatario" /></span>

                        <span class="property-value" aria-labelledby="signatario-label"><g:fieldValue bean="${documentoInstance}" field="signatario"/></span>

                    </li>
                </g:if>

                <g:if test="${documentoInstance?.municipio}">
                    <li class="fieldcontain">
                        <span id="municipio-label" class="property-label"><g:message code="documento.municipio.label" default="Municipio" /></span>

                        <span class="property-value" aria-labelledby="municipio-label">${documentoInstance?.municipio?.encodeAsHTML()}</span>

                    </li>
                </g:if>
                <g:if test="${documentoInstance?.localidad}">
                    <li class="fieldcontain">
                        <span id="localidad-label" class="property-label"><g:message code="documento.localidad.label" default="Localidad" /></span>

                        <span class="property-value" aria-labelledby="localidad-label">${documentoInstance?.localidad?.encodeAsHTML()}</span>

                    </li>
                </g:if>
                <g:if test="${documentoInstance?.evento}">
                    <li class="fieldcontain">
                        <span id="evento-label" class="property-label"><g:message code="documento.evento.label" default="Evento" /></span>

                        <span class="property-value" aria-labelledby="evento-label"><g:fieldValue bean="${documentoInstance}" field="evento"/></span>

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
                
                <g:if test="${documentoInstance?.clasificacion}">
                    <span id="header-label" class="property-label"><h3>Clasificación Archivistica</h3> </span>
                    <li class="fieldcontain">
                        <span id="dependencia-label" class="property-label"><g:message code="documento.clasifificacion.label" default="Dependencia" /></span>
                        <span class="property-value" aria-labelledby="prioridad-label"><g:fieldValue bean="${documentoInstance.clasificacion}" field="dependencia"/></span>
                        <span id="tipo-label" class="property-label"><g:message code="documento.clasifificacion.label" default="Tipo de Dependencia" /></span>
                        <span class="property-value" aria-labelledby="prioridad-label"><g:fieldValue bean="${documentoInstance.clasificacion}" field="tipoDependencia"/></span>
                        <span id="clave-label" class="property-label"><g:message code="documento.clasifificacion.label" default="Clave" /></span>
                        <span class="property-value" aria-labelledby="prioridad-label"><g:fieldValue bean="${documentoInstance.clasificacion}" field="clave"/></span> 
                        <span id="anio-label" class="property-label"><g:message code="documento.clasifificacion.label" default="Año" /></span>
                        <span class="property-value" aria-labelledby="prioridad-label"><g:formatDate id="anio" bean="${documentoInstance.clasificacion}" field="anio" format="yyyy"/></span>


                    </li>
                </g:if>

                <g:if test="${documentoInstance?.upload}">
                    <li class="fieldcontain">
                        <span id="nota-label" class="property-label"><g:message code="documento.nota.label" default="Archivo" /></span>

                        <span class="property-value" aria-labelledby="nota-label"><g:link  action="downloadFile" id="${documentoInstance?.id}" params="['id': documentoInstance?.id, 'folio': documentoInstance?.folio]" title="Descargar Escaneo" controller="documento"> <img src="${resource(dir:'images/skin',file:'escaneo.png')}" width="" height="" />    </g:link></span>
                            <span class="property-value" aria-labelledby="nota-label">

                            <g:uploadForm action="uploadFile" enctype="multipart/form-data">
                                <g:hiddenField name="foly" value="${documentoInstance?.folio}" />
                                <g:hiddenField name="documentoiD" value="${documentoInstance?.id}" />
                                <input type="file" name="myFile" />
                                <input type="submit" value="Guardar" />
                            </g:uploadForm>
                        </span>
                    </li>
                </g:if>
                <g:elseif test="${!documentoInstance?.upload}">
                    <span id="nota-label" class="property-label"><g:message code="documento.nota.label" default="Archivo" /></span>

                    <span class="property-value" aria-labelledby="nota-label">

                        <g:uploadForm action="uploadFile" enctype="multipart/form-data">
                            <g:hiddenField name="foly" value="${documentoInstance?.folio}" />
                            <g:hiddenField name="documentoiD" value="${documentoInstance?.id}" />
                            <input type="file" name="myFile" />
                            <input type="submit" value="Guardar"/>
                        </g:uploadForm>
                    </span>


                </g:elseif></br></br>
                <g:if test="${!documentoInstance?.clasificacion}">  
                    <span id="header-label" class="property-label"><h3>Clasificación Archivistica</h3> </span>
                    <li class="fieldcontain">
                        <span id="tipoDependencia-label" class="property-label"><g:message code="documento.nota.label" default="Tipo de Dependencia" /></span>
                         <span class="property-value" aria-labelledby="nota-label">
                         <g:uploadForm action="updateDocumento" enctype="multipart/form-data">
                         <g:hiddenField name="documentoiD" value="${documentoInstance?.id}" />
                         <g:select id="tipoDependencia" name="tipoDependencia" from="${['ESTATAL':'Estatales','FEDERAL':'Federales','INTERNO':'Interno']}"  onchange="cargaDependencias()" value="" class="many-to-many" optionKey="key" optionValue="value" noSelection="${['null':'Seleccione...']}" style=" width:200px"/>
                         </span>
                    </li> 
                    <li class="fieldcontain">
                        <span id="clasificacion-label" class="property-label"><g:message code="documento.clasificacion.label" default="Dependencia" /></span>
                        <span class="property-value" aria-labelledby="nota-label">
                        <g:select id="clasificacion" name="clasificacion"  from="" noSelection="${['null ':'Seleccione...']}" style=" width: 400px" optionKey="id" value="${documentoInstance?.clasificacion?.id}" class="many-to-one"/>
                        </span>
                        </br>  
                        <span class="property-value" aria-labelledby="nota-label">
                        <input type="submit" value="Guardar"/>
                        </g:uploadForm>
                        </span>
                    </li>
                </g:if>
                    


            </ol>
            <g:form>
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${documentoInstance?.id}" />
                    <g:if test="${documentoInstance?.folio[0]=="G"}">
                         <g:link class="edit" action="editGiras" id="${documentoInstance?.id}">Editar Documento</g:link>   
                    </g:if>    
                    <g:else>
                        <g:link class="edit" action="edit" id="${documentoInstance?.id}">Editar Documento</g:link>
                    </g:else>   
                     <sec:ifAnyGranted roles="ROLE_DCCA, ROLE_GIRAS">   
                        <g:link class="save" action="agregarDependenciasNombre" controller="turnado" id="${documentoInstance?.id}">Agregar Turnado</g:link>
                    </sec:ifAnyGranted>

                    <g:if test="${documentoInstance?.status!=0}">
                        <g:link class="save" action="agregarSeguimiento" controller="seguimiento" id="${documentoInstance?.id}">Agregar Seguimiento</g:link>
                    </g:if>
                     <sec:ifAnyGranted roles="ROLE_RECEPCION">   
                        <g:link class="save" action="agregarRespuesta" controller="respuesta" id="${documentoInstance?.id}">Agregar Respuesta</g:link>
                     </sec:ifAnyGranted> 
                    
                </fieldset>
            </g:form>
            <br>

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

            <g:if test="${documentoInstance?.folio[0]=="G"}">
                    <g:if test="${documentoInstance?.status==0}">
                        <span class="property-value" aria-labelledby="status-label"><h1>No se pueden generar reportes...</h1></span>
                    </g:if>
                    <g:elseif test="${documentoInstance?.status==1 || documentoInstance?.status==2 || documentoInstance?.status==3}">
                        <table>
                            <th>Nombre de Reporte</th>
                            <th>Generar Reporte</th>
                            <tr>
                                <td><h1>Giras - ordinario</h1></td>
                                <td><g:jasperReport jasper="giras" format="PDF,DOCX" name="" action="girasPDF" controller="reporte">
                                    <g:hiddenField name="idDocumento" value="${documentoInstance?.id}"/>
                                    <g:hiddenField name="presente" value="${documentoInstance?.presente}" />
                                    <g:hiddenField name="folio" value="${documentoInstance?.folio}" />
                                    <g:hiddenField name="fechaCaptura" value="${documentoInstance?.fechaCaptura}" />
                                    <g:hiddenField name="municipio" value="${documentoInstance?.municipio?.nombre}" />
                                    <g:hiddenField name="remitente" value="${documentoInstance?.persona?.nombre}" />
                                    <g:hiddenField name="dependenciaRemitente" value="${documentoInstance?.dependenciaRemitente?.nombre}" />
                                    <g:hiddenField name="asunto" value="${documentoInstance?.asunto}" />
                                    <g:hiddenField name="indicacion" value="${documentoInstance?.indicacionTexto}" />
                                    <g:hiddenField name="observacion" value="${documentoInstance?.observacion}" />
                                    </g:jasperReport></td>
                            </tr>
                            <tr>
                                <td><h1>GIRAS - Municipal - Federal</h1></td>
                                <td><g:jasperReport jasper="giras-municipal-federal" format="PDF,DOCX" name="" action="girasPDF" controller="reporte">
                                    <g:hiddenField name="idDocumento" value="${documentoInstance?.id}"/>
                                    <g:hiddenField name="presente" value="${documentoInstance?.presente}" />
                                    <g:hiddenField name="folio" value="${documentoInstance?.folio}" />
                                    <g:hiddenField name="fechaCaptura" value="${documentoInstance?.fechaCaptura}" />
                                    <g:hiddenField name="municipio" value="${documentoInstance?.municipio?.nombre}" />
                                    <g:hiddenField name="remitente" value="${documentoInstance?.persona?.nombre}" />
                                    <g:hiddenField name="dependenciaRemitente" value="${documentoInstance?.dependenciaRemitente?.nombre}" />
                                    <g:hiddenField name="asunto" value="${documentoInstance?.asunto}" />
                                    <g:hiddenField name="indicacion" value="${documentoInstance?.indicacionTexto}" />
                                    <g:hiddenField name="observacion" value="${documentoInstance?.observacion}" />
                                    </g:jasperReport></td>
                            </tr>
                        </table>     
                    </g:elseif>
            </g:if>
            <g:elseif test="${documentoInstance?.folio[0]=="D" || documentoInstance?.folio[0]=="S"}">
                    <g:if test="${documentoInstance?.status==0}">
                        <span class="property-value" aria-labelledby="status-label"><h1>No se pueden generar reportes...</h1></span>
                    </g:if>
                    <g:elseif test="${documentoInstance?.status==1 || documentoInstance?.status==2 || documentoInstance?.status==3}">
                        <table>
                            <th>Nombre de Reporte</th>
                            <th>Generar Reporte</th>
                            <tr>
                                <td><h1>Volante Ordinario-Carta Municipal-Federal</h1></td>
                                <td><g:jasperReport jasper="volanteOrdinario-1" format="PDF,PPTX" name="" action="volanteOrdinarioPDF" controller="reporte">
                                    <g:hiddenField name="idDocumento" value="${documentoInstance?.id}" id="volanteOrdinario" />
                                    <g:hiddenField name="presente" value="${documentoInstance?.presente}" />
                                    <g:hiddenField name="folio" value="${documentoInstance?.folio}" />
                                    <g:hiddenField name="fechaCaptura" value="${documentoInstance?.fechaCaptura}" />
                                    <g:hiddenField name="municipio" value="${documentoInstance?.municipio?.nombre}" />
                                    <g:hiddenField name="remitente" value="${documentoInstance?.persona?.nombre}" />
                                    <g:hiddenField name="dependenciaRemitente" value="${documentoInstance?.dependenciaRemitente?.nombre}" />
                                    <g:hiddenField name="asunto" value="${documentoInstance?.asunto}" />
                                    <g:hiddenField name="indicacion" value="${documentoInstance?.indicacionTexto}" />
                                    </g:jasperReport></td>
                            </tr>
                            <tr>
                               <td><h1>Sobre</h1></td>
                               <td><g:jasperReport jasper="sobreCarta" format="PDF,PPTX" name="" action="reporteSobrePDF" controller="reporte">
                                   <g:hiddenField name="idDocumento" value="${documentoInstance?.id}" id="volanteOrdinario" />
                                   <g:hiddenField name="municipio" value="${documentoInstance?.municipio?.nombre}" />
                                   <g:hiddenField name="remitente" value="${documentoInstance?.persona?.nombre}" />
                                   <g:hiddenField name="dependenciaRemitente" value="${documentoInstance?.dependenciaRemitente?.nombre}" />
                                   </g:jasperReport></td>
                            </tr>
                            <tr>
                              <td><h1>Memorandum</h1> </td>
                              <td><g:jasperReport jasper="memo" format="PDF,PPTX" name="" action="memoPDF" controller="reporte">
                                    <g:hiddenField name="idDocumento" value="${documentoInstance?.id}" id="volanteOrdinario" />
                                    <g:hiddenField name="presente" value="${documentoInstance?.presente}" />
                                    <g:hiddenField name="folio" value="${documentoInstance?.folio}" />
                                    <g:hiddenField name="fechaCaptura" value="${documentoInstance?.fechaCaptura}" />
                                    <g:hiddenField name="municipio" value="${documentoInstance?.municipio?.nombre}" />
                                    <g:hiddenField name="remitente" value="${documentoInstance?.persona?.nombre}" />
                                    <g:hiddenField name="dependenciaRemitente" value="${documentoInstance?.dependenciaRemitente?.nombre}" />
                                    <g:hiddenField name="asunto" value="${documentoInstance?.asunto}" />
                                    <g:hiddenField name="indicacion" value="${documentoInstance?.indicacionTexto}" />
                                </g:jasperReport></td>
                            </tr>
                            <tr>
                               <td> <h1>Carta Respuesta</h1></td> 
                               <td><g:jasperReport jasper="cartaRespuesta" format="PDF,PPTX" name="" action="cartaRespuestaPDF" controller="reporte">
                                    <g:hiddenField name="idDocumento" value="${documentoInstance?.id}"/>
                                    <g:hiddenField name="municipio" value="${documentoInstance?.municipio?.nombre}" />
                                    <g:hiddenField name="remitente" value="${documentoInstance?.persona?.nombre}" />
                                    <g:hiddenField name="dependenciaRemitente" value="${documentoInstance?.dependenciaRemitente?.nombre}" />
                                </g:jasperReport></td>
                           </tr>
                           <tr>
                              <td><h1>Carta No Apoyo</h1></td>
                              <td> <g:jasperReport jasper="cartaDeNoApoyo" format="PDF,PPTX" name="" action="cartaDeNoApoyoPDF" controller="reporte">
                                    <g:hiddenField name="idDocumento" value="${documentoInstance?.id}"/>
                                    <g:hiddenField name="municipio" value="${documentoInstance?.municipio?.nombre}" />
                                    <g:hiddenField name="remitente" value="${documentoInstance?.persona?.nombre}" />
                                    <g:hiddenField name="dependenciaRemitente" value="${documentoInstance?.dependenciaRemitente?.nombre}" />
                                </g:jasperReport></td>
                          </tr>
                          <tr>
                                <td><h1>Volante Municipal-Federal</h1></td>
                                <td><g:jasperReport jasper="volanteMunicipal" format="PDF,DOCX" name="" action="volanteMunicipal" controller="reporte">
                                    <g:hiddenField name="idDocumento" value="${documentoInstance?.id}" id="volanteOrdinario" />
                                    <g:hiddenField name="presente" value="${documentoInstance?.presente}" />
                                    <g:hiddenField name="folio" value="${documentoInstance?.folio}" />
                                    <g:hiddenField name="fechaCaptura" value="${documentoInstance?.fechaCaptura}" />
                                    <g:hiddenField name="municipio" value="${documentoInstance?.municipio?.nombre}" />
                                    <g:hiddenField name="remitente" value="${documentoInstance?.persona?.nombre}" />
                                    <g:hiddenField name="dependenciaRemitente" value="${documentoInstance?.dependenciaRemitente?.nombre}" />
                                    <g:hiddenField name="asunto" value="${documentoInstance?.asunto}" />
                                    <g:hiddenField name="indicacion" value="${documentoInstance?.indicacionTexto}" />
                                    </g:jasperReport></td>
                            </tr>
                            <tr>
                                <td><h1>Volante Ordinario</h1></td>
                                <td><g:jasperReport jasper="volanteOrdinario" format="PDF,DOCX" name="" action="volanteOrdinario" controller="reporte">
                                    <g:hiddenField name="idDocumento" value="${documentoInstance?.id}" id="volanteOrdinario" />
                                    <g:hiddenField name="presente" value="${documentoInstance?.presente}" />
                                    <g:hiddenField name="folio" value="${documentoInstance?.folio}" />
                                    <g:hiddenField name="fechaCaptura" value="${documentoInstance?.fechaCaptura}" />
                                    
                                    <g:hiddenField name="remitente" value="${documentoInstance?.persona?.nombre}" />
                                    <g:hiddenField name="dependenciaRemitente" value="${documentoInstance?.dependenciaRemitente?.nombre}" />
                                    <g:hiddenField name="asunto" value="${documentoInstance?.asunto}" />
                                    <g:hiddenField name="indicacion" value="${documentoInstance?.indicacionTexto}" />
                                    </g:jasperReport></td>
                            </tr>
                        </table>
                    </g:elseif>
            </g:elseif>
        </div>
    </body>
</html>
