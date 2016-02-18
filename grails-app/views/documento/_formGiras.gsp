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



<g:javascript>   
    $('#nombreRemitente').keyup(function() {
    var tamano = document.getElementById('nombreRemitente').value;
    var t = tamano.length
    var intValue = parseInt(t);
    if(intValue >= 2){

    $.ajax({
    url: '<%=request.getContextPath()%>'+'/documento/buscadorAjaxDependencias/',  
    method: 'GET',
    data:{id:document.getElementById('nombreRemitente').value},
    success: function(objeto){             


    /**/
    if (objeto) {
    var rselect = document.getElementById('id_Dependencia')


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

<g:javascript> 
 /*Carga localidades*/

    function cargaLocalidades(){
   
        $.ajax({
            url: '/SGC/Documento/ajaxGetLocalidad/',  
            method: 'GET',
            data:{id:document.getElementById('municipio').value},
            success: function(objeto){             
        /**/
            if (objeto) {
                var rselect = document.getElementById('localidad')

                // Clear all previous options 
                var l = rselect.length
                while (l > 0) {
                    l-- 
                    rselect.remove(l) 
                }

                if(1 > objeto.length){
                    alert('No hay localidades registrados para este Municipio')
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
    failure: function(){

    }
    });

    }

</g:javascript>
<style>
    .ui-resizable-se {

    bottom: 17px;

    }

</style>

<script>
    
    function newPopup(url) {
	popupWindow = window.open(
		url,'popUpWindow','height=700,width=1000,left=200,top=10,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=yes')
    }

    function giveIdicaciones(){

    var posicion=document.getElementById('indicacion').options.selectedIndex; //posicion

    
    var e = document.getElementById("indicacion");
    var str = e.options[e.selectedIndex].text;
    document.documento.indicacionTexto.value=str


    }

    function givePresente(){

    var Municipal="EN CONOCIMIENTO Y CON RESPETO A LA AUTONOMÍA MUNICIPAL Y POR NO TRATARSE "+
    "DE LA COMPETENCIA ESTATAL, ME PERMITO ANEXAR ESCRITO DIRIGIDO AL C. GRACO "+
    "RAMÍREZ GARRIDO ABREU, GOBERNADOR CONSTITUCIONAL DEL ESTADO DE MORELOS.";
    var noApoyo="En su ejercicio de derecho de petición, me permito de la manera más atenta "+
    "dar contestación a su escrito dirigido al C. Gobernador Constitucional del Estado "+
    "de Morelos, en donde solicita apoyo para cubrir gastos de los festejos de las fiestas "+
    "patronales. Me permito informarle que el Gobierno del Estado no cuenta con presupuesto "+
    "para dar este tipo de apoyos.";
    
     var Federal="EN CONOCIMIENTO Y CON RESPETO A LA AUTONOMÍA FEDERAL Y POR NO TRATARSE "+
    "DE LA COMPETENCIA ESTATAL, ME PERMITO ANEXAR ESCRITO DIRIGIDO AL C. GRACO "+
    "RAMÍREZ GARRIDO ABREU, GOBERNADOR CONSTITUCIONAL DEL ESTADO DE MORELOS.";
    var noApoyo="En su ejercicio de derecho de petición, me permito de la manera más atenta "+
    "dar contestación a su escrito dirigido al C. Gobernador Constitucional del Estado "+
    "de Morelos, en donde solicita apoyo para cubrir gastos de los festejos de las fiestas "+
    "patronales. Me permito informarle que el Gobierno del Estado no cuenta con presupuesto "+
    "para dar este tipo de apoyos.";

    var volanteOrdinario="Con fundamento en los artículos 1, 2, 3, 4, 9 y 10 fracción VIII del reglamento interior de la 'Oficina de la Gubernatura del Estado' publicado en el periódico oficial Tierra y Libertad número 5353 con fecha 18 de Diciembre de 2015; 11 y 13 de la Ley Orgánica de la Administración Pública del Estado de Morelos, le remito el siguiente asunto:";
    
    var cartaRespuesta="Me permito dar contestación a su solicitud de fecha <g:formatDate date="${documentoInstance?.fechaCaptura}" format="dd-MMM-yyyy" /> "+
    "presentada en esta secretaría, informando a usted, que por instrucciones del "+
    "C. Graco Ramírez Garrido Abreu, gobernador Constitucional del Estado de Morelos,"+
    "su petición ha sido turnada a:";
    
    var giras="Por indicaciones del C. Graco Ramírez Garrido Abreu, Gobernador Constitucional "+
    "del Estado de Morelos, le remito para su atención el asunto recibido en gira de trabajo.";


    var valorCombo=document.getElementById('comboPresente').value;
    
    if(valorCombo=="Carta de No Apoyo"){

    document.documento.presente.value=noApoyo;
    }
    else if(valorCombo=="Municipal"){

    document.documento.presente.value=Municipal;
    }
    else if(valorCombo=="Federal"){

    document.documento.presente.value=Federal;
    }
    else if(valorCombo=="Volante Ordinario"){

    document.documento.presente.value=volanteOrdinario;
    }
    else if(valorCombo=="Carta Respuesta"){
    document.documento.presente.value=cartaRespuesta;
    }
    else if(valorCombo=="Giras"){
    document.documento.presente.value=giras;
    }
    }
</script>


<script>
    $(function() {
    $( "#resizable" ).resizable({
    handles: "se"
    });
    });
</script>

<div style=" display: none">
    <g:hiddenField name="myField" value="myValue" id="resizable" />
</div>

<g:hiddenField name="documentoiD" value="${documentoInstance?.id}" />

<g:if test="${documentoInstance?.persona}">
    <li class="fieldcontain">
        <span id="persona-label" class="property-label"><g:message code="documento.persona.label" default="Remitente" /></span>

        <span class="property-value" aria-labelledby="persona-label">${documentoInstance?.persona?.encodeAsHTML()}</span>

    </li>
    <g:hiddenField name="remitentePer" value="${documentoInstance.persona}" />
</g:if>

<g:if test="${documentoInstance?.dependenciaRemitente}">
    <li class="fieldcontain">
        <span id="persona-label" class="property-label"><g:message code="documento.persona.label" default="Remitente" /></span>

        <span class="property-value" aria-labelledby="persona-label">${documentoInstance?.dependenciaRemitente?.encodeAsHTML()}</span>

    </li>
    <g:hiddenField name="remitenteDep" value="${documentoInstance.dependenciaRemitente}" />
</g:if>


<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'documentos', 'error')} ">
    <label for="remitente">
        <g:message code="documento.remitente.label" default="Nombre" />
    </label>
    <g:textField name="nombreRemitente" id="nombreRemitente" placeholder="Escribe el remitente"  maxlength="210" value="" onkeyup="" size="20px"/>

</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'documentos', 'error')} ">
    <label for="remitentes">
        <g:message code="documento.remitente.label" default="Remitentes" />

    </label>
    <g:select id="id_Remitente" name="persona.id" from="" multiple="multiple" optionKey="id" size="5" value="${documentoInstance?.persona*.id}" class="many-to-many" style=" width: 450px"/>
    <a href="JavaScript:newPopup('${createLink(controller: 'Persona',action:"create")}')"><img src="${resource(dir: 'images', file: 'remitent.png')}"/></a>            
 <!--   <a href="${createLink(controller: 'Persona',action:"create")}"><img src="${resource(dir: 'images', file: 'remitent.png')}"/></a>            -->
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'documentos', 'error')} ">
    <label for="remitentes">
        <g:message code="documento.dependenciaRemitente.label" default="Dependencias" />

    </label>
    <g:select id="id_Dependencia" name="dependenciaRemitente.id" from="" multiple="multiple" optionKey="id" size="5" value="${documentoInstance?.dependenciaRemitente*.id}" class="many-to-many" style=" width: 450px"/>
    <a href="JavaScript:newPopup('${createLink(controller: 'Dependencia',action:"create")}')"><img src="${resource(dir: 'images', file: 'dependencia.png')}"/></a>    
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'asunto', 'error')} required">
    <label for="asunto">
        <g:message code="documento.asunto.label" default="Asunto" />
        <span class="required-indicator">*</span>
    </label>
    <g:textArea name="asunto" required="" value="${documentoInstance?.asunto}" id="resizable" />
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'presente', 'error')} required">
    <label for="presente">
        <g:message code="documento.presente.label" default="Presente" />
        <span class="required-indicator">*</span>
    </label>
    <g:textArea name="presente" id="resizable" required="" value="${documentoInstance?.presente}"/>
    <g:select name="combo" id="comboPresente" from="${['Seleccione...','Carta de No Apoyo', 'Volante Ordinario', 'Municipal', 'Federal', 'Carta Respuesta', 'Giras']}" onchange="givePresente()"/>
</div>

<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'tipoDocumento', 'error')} ">
    <label for="tipoDocumento">
        <g:message code="documento.tipoDocumento.label" default="Tipo Documento" />

    </label>
    <g:select id="idTipoDocumento" name="tipoDocumento.id" from="${TipoDocumento.list(sort:'tipoDocumento')}" required="true" multiple="multiple" optionKey="id" size="5" value="${documentoInstance?.tipoDocumento*.id}" class="many-to-many" style=" width: 450px"/>
    <a href="JavaScript:newPopup('${createLink(controller: 'TipoDocumento',action:"create")}')"><img src="${resource(dir: 'images', file: 'tipoDoc.png')}"/></a>            
</div>

<!--Indicacion-->
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'indicacion', 'error')} required">
    <label for="indicacion">
        <g:message code="documento.indicacion.label" default="Indicaciones:" />
        <span class="required-indicator">*</span>
    </label>
    <g:select id="indicacion" style="width: 265px;" name="indicacion.id" noSelection="${['null':'Seleccione...']}" onchange="giveIdicaciones()" from="${Indicacion.list()}" optionKey="id" required="" value="${documentoInstance?.indicacion?.id}" class="many-to-one" />
    <g:hiddenField name="indica" value="${indicacionInstance.indicacion}" />
</div>

<!--FieldText Modificación Indicación-->
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'indicacion', 'error')} ">
<label for="indicacion">
        <g:message code="documento.indicacion.label" default="Editar:" />
        <span class="required-indicator">*</span>
</label>
    <span class="property-value" aria-labelledby="persona-label">
    <g:textArea name="indicacionTexto" required="" value="${documentoInstance.indicacionTexto}" id="resizable"/>
    </span>
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'observacion', 'error')} required">
    <label for="observacion">
        <g:message code="documento.observacion.label" default="Observacion" />
        
    </label>
    <g:textArea name="observacion"  value="${documentoInstance?.observacion}" id="resizable" />
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'fechaCaptura', 'error')} required" style=" display: none">
    <label for="fechaCaptura">
        <g:message code="documento.fechaCaptura.label" default="Fecha de Captura" />
        <span class="required-indicator">*</span>
    </label>
    <g:datePicker name="fechaCaptura" precision="day" readonly="true" value="${documentoInstance?.fechaCaptura}"/>
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'municipio', 'error')} required">
    <label for="municipio">
        <g:message code="documento.municipio.label" default="Municipio" />
        <span class="required-indicator">*</span>
    </label>
   
    <g:select id="municipio" name="municipio.id" noSelection="${['null':'Seleccione...']}" value="${documentoInstance?.municipio?.id}" from="${['901': 'Cuernavaca','895': 'Amacuzac', '896': 'Atlatlahucan', '897': 'Axochiapan', '898': 'Ayala', '899': 'Coatlán del Río', '900': 'Cuautla', '902' : 'Emiliano Zapata', '903': 'Huitzilac', '904': 'Jantetelco', '905': 'Jiutepec', '906': 'Jojutla', '907': 'Jonacatepec', '908': 'Mazatepec', '909': 'Miacatlán', '910': 'Ocuituco', '911': 'Puente de Ixtla', '912': 'Temixco', '913': 'Tepalcingo', '914': 'Tepoztlán', '915': 'Tetecala', '916': 'Tetela del Volcán', '917': 'Tlalnepantla', '918': 'Tlatizapán de Zapata', '919': 'Tlalquitenango', '920': 'Tlayacapan', '921': 'Totolapan', '922': 'Xochitepec', '923': 'Yautepec', '924': 'Yecapixtla', '925': 'Zacatepec','926': 'Zacualpan', '927': 'Temoac', ]}" optionKey="key" onchange="cargaLocalidades()" optionValue="value" class="many-to-one"/>
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'localidad', 'error')} required">
    <label for="localidad">
    <g:message code="documento.estado.label" default="Localidad:" />
    <span class="required-indicator">*</span>
    </label>
    <g:select id="localidad" name="localidad.id"  from="" noSelection="${['null':'Seleccione...']}" required="" style=" width: 400px" optionKey="id" required="" value="${documentoInstance?.localidad?.id}" class="many-to-one"/>
    
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'documentos', 'error')} ">
    <label for="evento">
        <g:message code="documento.evento.label" default="Evento" />
    </label>
    <g:textField name="evento" id="evento" placeholder="Escribe el nombre del evento" value="${documentoInstance?.evento}" maxlength="260" onkeyup="" size="40px"/>

</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'fechaRecibido', 'error')} required">
    <label for="fechaRecibido">
        <g:message code="documento.fechaRecibido.label" default="Fecha Recibido" />
        <span class="required-indicator">*</span>
    </label>
    <g:datePicker name="fechaRecibido" precision="day"  value="${documentoInstance?.fechaRecibido}"  />
</div>


<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'prioridad', 'error')} ">
    <label for="prioridad">
        <g:message code="documento.prioridad.label" default="Prioridad" />

    </label>
    <g:select name="prioridad" from="${documentoInstance.constraints.prioridad.inList}" value="${documentoInstance?.prioridad}" valueMessagePrefix="documento.prioridad" />
</div>


