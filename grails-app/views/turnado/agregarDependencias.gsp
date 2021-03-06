<html>
    <%@ page contentType="text/html;charset=UTF-8" %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'turnado.label', default: 'Turnado')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>

<!-- Scrips con jQuery-->
        <g:javascript> 

            /*Carga unidades*/

            function cargaUnidades(){

            $.ajax({
            url: '/SGC/turnado/ajaxGetUnidadesAdmin/',  
            method: 'GET',
            data:{id:document.getElementById('dependenciaID').value},
            success: function(objeto){             


            /**/
            if (objeto) {
            var rselect = document.getElementById('idunidad')

            // Clear all previous options 
            var l = rselect.length
            while (l > 0) {
            l-- 
            rselect.remove(l) 
            }

            if(1 > objeto.length){
            alert('No hay personas registradas en esta unidad')
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

            opt.text = producto.nombre;
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
            failure: function(){}
            });

            }







            /*Carga personas*/

            function cargaPersonas(){

            $.ajax({
            url: '/SGC/turnado/ajaxGetPersonaResponsable/',  
            method: 'GET',
            data:{id:document.getElementById('idunidad').value},
            success: function(objeto){             


            /**/
            if (objeto) {
            var rselect = document.getElementById('idpersona')

            // Clear all previous options 
            var l = rselect.length
            while (l > 0) {
            l-- 
            rselect.remove(l) 
            }

            if(1 > objeto.length || objeto==null){
            alert('No hay personas registradas en esta unidad')
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
            var persona = objeto[i]; 
            var opt = new Option(); 

            opt.text = persona.nombre;
            opt.value =persona.id;

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

            }

        </g:javascript>

        <script>

            function validaSelect(){

            var valor=document.getElementById("dependenciaID").value

            if(valor =="null"){
            alert("Debes seleccionar una dependencia...")
            return false
            }//fin if
            else{

            return true
            }

            }
        </script>

        <script>
            $(function() {
            $( "#tabs" ).tabs();
            });
        </script>

    </head>
    <body>

        <div id="create-credito" class="content scaffold-create" role="main">

            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:if test="${flash.error}">
                <div class="errors">${flash.error}</div>
            </g:if>
            <h1>Agregar dependencias a turnar</h1>
            <g:form action="send" onsubmit="return validaSelect()">
                <fieldset class="form">


                    <div id="tabs">
                        <ul>
                            <li><a href="#tabs-1">Asignación Dependencias-Unidad</a></li>
                            <li><a href="#tabs-2">Generar Reporte</a></li>

                        </ul>
                        <div id="tabs-1">

                            <div style="width:300px" >

                                <table>

                                    <tr class="prop">
                                        <td valign="top" class="name">Folio del documento:
                                        </td>
                                        <td valign="top" class="value ${hasErrors(bean: depositoInstance, field: 'grupo', 'errors')}">
                                            <g:textField name="folio"  maxlength="250" value="${documentoInstance?.folio}" onkeyup="" size="24px" readOnly="true"/>
                                            <g:hiddenField name="documento.id" value="${documentoInstance?.id}" /></td>
                                        <g:hiddenField name="document" value="${documentoInstance?.id}" /></td>
                                    </tr>

                                    <tr class="prop">
                                        <td valign="top" class="name">Dependencia:
                                        </td>
                                        <td valign="top" class="value ${hasErrors(bean: dependenciaInstance, field: 'dependencia', 'errors')}">
                                            <g:select id="dependenciaID" name="dependencia.id" required="" from="${Dependencia.list()}" noSelection="${['null':'Seleccione...']}" optionKey="id" onchange="cargaUnidades()" required="" value="" class="many-to-one" style=" width: 400px "/></td>
                                    </tr>


                                    <tr class="prop">
                                        <td valign="top" class="name">Unidad Administrativa:
                                        </td>
                                        <td valign="top" class="value ${hasErrors(bean: unidadAdminInstance, field: 'unidadAdmin', 'errors')}">
                                            <g:select id="idunidad" name="unidadAdmin.id" required="true" from="" noSelection="${['null':'Seleccione...']}" optionKey="id" onchange="cargaPersonas()"  value="" class="many-to-one" style=" width: 400px "/> 
                                    </tr>

                                    <tr class="prop">
                                        <td valign="top" class="name">Persona Responsable:
                                        </td>
                                        <td valign="top" class="value ${hasErrors(bean: unidadAdminInstance, field: 'persona', 'errors')}">
                                            <g:select id="idpersona" name="persona.id" required="true" from="" noSelection="${['null':'Seleccione...']}" optionKey="id"  value="" class="many-to-one" style=" width: 400px "/> 
                                    </tr>


                                    <tr class="prop">
                                        <td valign="top" class="name">Responsabilidad:
                                        </td>
                                        <td valign="top" class="value ${hasErrors(bean: turnadoInstance, field: 'responsabilidad', 'errors')}">
                                            <g:select name="responsabilidad" from="${['RESPONSABLE', 'CCP']}" required="true" noSelection="['': '']"/>
                                    </tr>


                                </table>

                            </div>

                            <div class="buttons">
                                <span class="button"><g:actionSubmit value="Agregar" action="saveDependenciasTurnadas"  class="save" /></span>
                            </div>


                            </br>
                            <h4>Dependencias y unidades agregadas:</h4>
                            <table style=" font-size: 11px;">
                                <thead>
                                    <tr>

                                        <g:sortableColumn property="nombre" title="${message(code: 'turnado.nombre.label', default: 'No')}" />

                                        <g:sortableColumn property="nombre" title="${message(code: 'turnado.documento.label', default: 'Documento')}" />

                                        <g:sortableColumn property="nombre" title="${message(code: 'turnado.nombre.label', default: 'Dependencia')}" />

                                        <g:sortableColumn property="cargo" title="${message(code: 'turnado.nombre.label', default: 'Unidad Admin')}" />

                                        <g:sortableColumn property="responsabilidad" title="${message(code: 'turnado.responsabilidad.label', default: 'Responsabilidad')}" />

                                        <g:sortableColumn property="responsable" title="${message(code: 'turnado.nombre.label', default: 'Persona')}" />

                                        <g:sortableColumn property="eliminar" title="${message(code: 'turnado.nombre.label', default: 'eliminar')}" />

                                    </tr>
                                </thead>
                                <tbody>
                                    <g:each in="${turnadoInstance}" status="i" var="turnado">
                                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">


                                            <td>${i + 1} </td>

                                            <td>${turnadoInstance[i]?.documento?.folio?.encodeAsHTML()}</td>

                                            <td>${turnadoInstance[i]?.dependencia?.nombre?.encodeAsHTML()}</td>

                                            <td>${turnadoInstance[i]?.unidadAdmin?.nombre?.encodeAsHTML()}</td>

                                            <td>${turnadoInstance[i]?.responsabilidad?.encodeAsHTML()}</td>

                                            <td>${turnadoInstance[i]?.persona?.nombre?.encodeAsHTML()}</td>

                                            <td>    


                                                <g:link  action="deleteDep" id="${turnadoInstance[i].id}" params="['documento.id': documentoInstance?.id]" controller="turnado" onclick="return confirm('${message(code: '¿Está seguro que desea quitar esta dependencia?', default: '¿Está seguro que desea quitar esta dependencia?')}');" > <img src="${resource(dir:'images',file:'deleter.png')}" width="" height="" />    </g:link>
                                                </td>

                                        </tr>
                                    </g:each>
                                </tbody>


                            </g:form>
                        </table>



                    </div>

                    <div id="tabs-2">


                        <g:if test="${turnadoInstance}">
                            <h1>Click para generar el reporte</h1>
                            <g:jasperReport jasper="turnado" format="PDF, PPTX" name="" action="turnadoPDF" controller="reporte">

                                <g:hiddenField name="idDoc" value="${documentoInstance?.id}"/>
                                <g:hiddenField name="folio" value="${documentoInstance?.folioFisico}"/>
                                <g:hiddenField name="remitente" value="${documentoInstance?.remitente?.persona?.nombre}"/>
                                <g:hiddenField name="fechaRecibido" value="${documentoInstance?.fechaRecibido}"/>
                                <g:hiddenField name="asunto" value="${documentoInstance?.asunto}"/>
                                <g:hiddenField name="instruccion" value="${documentoInstance?.instruccion}"/>
                                <g:hiddenField name="nota" value="${documentoInstance?.nota}"/>
                            </g:jasperReport>

                        </g:if>
                        <g:else>
                            <h4>¡Que tal! Aún no haz turnado este documento...</h4>
                        </g:else>

                        <br><br>

                        <g:if test="${turnadoInstance}">
<g:form action="send" method="post" enctype="multipart/form-data">
                        <div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'file', 'error')} required">
                            <label for="file">
                                <g:hiddenField name="document" value="${documentoInstance?.id}" /></td>
                                <g:message code="persona.file.label" default="Archivo:" />
                                <span class="required-indicator">*</span>
                            </label>
                            <input type="file" name="uploadedFile" required=""/>
                        </div>


                        <fieldset class="buttons">
                    <g:submitButton name="create" class="save" value="Enviar" />
                </fieldset>
                        </g:form>
                            
                            </g:if>
                    </div>


                </div>
            </fieldset>



        </div>
    </body>
</html>

