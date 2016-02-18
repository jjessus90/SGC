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
            <h1>Seguimientos</h1>
            <g:form >
                <fieldset class="form">


                    <div id="tabs">
                        <ul>
                            <li><a href="#tabs-1">Agregar Respuesta</a></li>
                            

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
                                        <td valign="top" class="name">Respuesta:
                                        </td>
                                        <td valign="top" class="value ${hasErrors(bean: respuestaInstance, field: 'respuesta', 'errors')}">
                                        <g:textArea name="respuesta" required="" value="" id="resizable" />    
                                        
                                    </tr>

                                </table>

                            </div>

                            <div class="buttons">
                                <span class="button"><g:actionSubmit value="Agregar" action="saveRespuesta"  class="save" /></span>
                                <g:if test="${documentoInstance}">
                            <g:link  action="show" id="${documentoInstance?.id}" params="['id': documentoInstance?.id]" title="Click mostrar detalle general del documento" controller="documento"> <img src="${resource(dir:'images/skin',file:'editDocument.png')}" width="" height="" />    </g:link>

                        </g:if>
                            </div>


                            </br>
                            <h4>Dependencias y unidades agregadas:</h4>
                            <table style=" font-size: 11px;">
                                <thead>
                                    <tr>

                                        <g:sortableColumn property="nombre" title="${message(code: 'turnado.nombre.label', default: 'No')}" />

                                        <g:sortableColumn property="nombre" title="${message(code: 'turnado.documento.label', default: 'Documento')}" />

                                        <g:sortableColumn property="nombre" title="${message(code: 'turnado.nombre.label', default: 'Respuesta')}" />

                                        <g:sortableColumn property="cargo" title="${message(code: 'turnado.nombre.label', default: 'Fecha Captura')}" />
                                        
                                        <g:sortableColumn property="eliminar" title="${message(code: 'turnado.nombre.label', default: 'Modificar')}" />

                                        <g:sortableColumn property="eliminar" title="${message(code: 'turnado.nombre.label', default: 'Eliminar')}" />

                                    </tr>
                                </thead>
                                <tbody>
                                    <g:each in="${respuestaInstance}" status="i" var="respuesta">
                                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">


                                            <td>${i + 1}</td>
                                            
                                            <td>${respuestaInstance[i]?.documento?.folio?.encodeAsHTML()}</td>

                                            <td>${respuestaInstance[i]?.respuesta?.encodeAsHTML()}</td>

                                            <td>
                                            <g:formatDate date="${respuestaInstance[i]?.fechaCaptura}" format="dd-MMM-yyyy" />
                                            </td>

                                            <td>
                                            
                                            <g:link  action="edit" id="${respuestaInstance[i].id}" params="['documento.id': documentoInstance?.id, 'id': respuestaInstance[i]?.id]" controller="respuesta"> <img src="${resource(dir:'images',file:'editCat.png')}" width="" height="" />    </g:link>
                                            </td>
                                            <td>    

                                                
                                                <g:link  action="deleteRespuesta" id="${respuestaInstance[i].id}" params="['documento.id': documentoInstance?.id]" controller="respuesta" onclick="return confirm('${message(code: '¿Está seguro que desea quitar esta respuesta?', default: '¿Está seguro que desea quitar esta respuesta?')}');" > <img src="${resource(dir:'images',file:'deleter.png')}" width="" height="" />    </g:link>
                                                </td>

                                        </tr>
                                    </g:each>
                                </tbody>


                            </g:form>
                        </table>



                    </div>



                </div>
            </fieldset>



        </div>
    </body>
</html>

