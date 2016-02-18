<g:javascript>   
$('#nombreRemitente').keyup(function() {
    var tamano = document.getElementById('nombreRemitente').value;
    var t = tamano.length
    var intValue = parseInt(t);
    if(intValue >= 2){

    $.ajax({
    url: '/SGC/documento/buscadorAjax/',  
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
    url: '/SGC/documento/buscadorAjaxDependencias/',  
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
<style>
  .ui-resizable-se {
    
    bottom: 17px;
    
  }
  
  </style>

<script>
  $(function() {
    $( "#resizable" ).resizable({
      handles: "se"
    });
  });
  
  function newPopup(url) {
	popupWindow = window.open(
		url,'popUpWindow','height=700,width=1000,left=200,top=10,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=yes')
    }
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
        <g:textField name="nombreRemitente" id="nombreRemitente"  maxlength="210" value="" onkeyup="" size="20px"/>  
  </div>
  
  
  
  
  <div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'documentos', 'error')} ">
        <label for="remitentes">
          <g:message code="documento.remitente.label" default="Remitentes" />

        </label>
        <g:select id="id_Remitente" name="persona.id" from="" multiple="multiple" optionKey="id" size="5" value="${documentoInstance?.persona*.id}" class="many-to-many" style=" width: 450px"/>
        <a href="JavaScript:newPopup('${createLink(controller: 'Persona',action:"create")}')"><img src="${resource(dir: 'images', file: 'remitent.png')}"/></a>            
  </div>
  <div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'documentos', 'error')} ">
        <label for="remitentes">
          <g:message code="documento.dependenciaRemitente.label" default="Dependencias" />

        </label>
        <g:select id="id_Dependencia" name="dependenciaRemitente.id" from="" multiple="multiple" optionKey="id" size="5" value="${documentoInstance?.dependenciaRemitente*.id}" class="many-to-many" style=" width: 450px"/>
  <a href="JavaScript:newPopup('${createLink(controller: 'Dependencia',action:"create")}')"><img src="${resource(dir: 'images', file: 'dependencia.png')}"/></a>    
  </div>
  <div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'dirigido', 'error')} required">
    <label for="dirigido">
        <g:message code="documento.municipio.label" default="Dirigido" />
        <span class="required-indicator">*</span>
    </label>
   
    <g:select id="dirigido" name="dirigido" value="${documentoInstance?.dirigido}" noSelection="${['null':'Seleccione...']}" from="${['Lic. Graco Luis Ramírez Garrido Abreu': 'Lic. Graco Luis Ramírez Garrido Abreu','D.A.H. Elizabeth Anaya Lazurtegui ': 'D.A.H. Elizabeth Anaya Lazurtegui ']}" optionKey="key" optionValue="value" class="many-to-one" required=""/>
</div>
  <div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'asunto', 'error')} required">
	<label for="asunto">
		<g:message code="documento.asunto.label" default="Asunto" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="asunto" required="" value="${documentoInstance?.asunto}" id="resizable" />
</div>

	<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'tipoDocumento', 'error')} ">
        <label for="tipoDocumento">
        	<g:message code="documento.tipoDocumento.label" default="Tipo Documento" />
        </label>
        <g:select id="idTipoDocumento" name="tipoDocumento.id" from="${TipoDocumento.list(sort:'tipoDocumento')}" multiple="multiple" optionKey="id" size="5" value="${documentoInstance?.tipoDocumento*.id}" class="many-to-many" style=" width: 450px"/>
		<a href="JavaScript:newPopup('${createLink(controller: 'TipoDocumento',action:"create")}')"><img src="${resource(dir: 'images', file: 'tipoDoc.png')}"/></a>            
	</div>

	<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'fechaCaptura', 'error')} required" style=" display: none">
		<label for="fechaCaptura">
    <g:message code="documento.fechaCaptura.label" default="Fecha de Captura" />
    <span class="required-indicator">*</span>
  </label>
  <g:datePicker name="fechaCaptura" precision="day" readonly="true" value="${documentoInstance?.fechaCaptura}"/>
	</div>
	<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'fechaRecibido', 'error')} required">
		<label for="fechaRecibido">
			<g:message code="documento.fechaRecibido.label" default="Fecha Recibido" />
			<span class="required-indicator">*</span>
		</label>
		<g:datePicker name="fechaRecibido" precision="day"  value="${documentoInstance?.fechaRecibido}"  />
	</div>
	
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'turnadoInterno', 'error')} ">
    <label for="turnadoInterno">
        <g:message code="documento.turnadoInterno.label" default="Turnado Interno" />
    </label>
     <g:checkBox name="turnadoInterno" id="turnadoInterno" value="Lic. Gustavo Martínez" checked="false"/>Lic. Gustavo Martínez
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'turnadoInterno', 'error')} ">
     <label for="turnadoInterno">
        <g:message code="documento.turnadoInterno.label" default="" />
    </label>
    <g:checkBox name="turnadoInterno" id="turnadoInterno" value="Lic. Mariana Ugalde" checked="false"/>Lic. Mariana Ugalde
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'turnadoInterno', 'error')} ">
     <label for="turnadoInterno">
        <g:message code="documento.turnadoInterno.label" default="" />
    </label>
    <g:checkBox name="turnadoInterno" id="turnadoInterno" value="C.P. María Josefina Cuevas" checked="false"/>C.P. María Josefina Cuevas
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'turnadoInterno', 'error')} ">
     <label for="turnadoInterno">
        <g:message code="documento.turnadoInterno.label" default="" />
    </label>
    <g:checkBox name="turnadoInterno" id="turnadoInterno" value="Lic. Sergio González Lawers" checked="false"/>Lic. Sergio González Lawers
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'turnadoInterno', 'error')} ">
     <label for="turnadoInterno">
        <g:message code="documento.turnadoInterno.label" default="" />
    </label>
    <g:checkBox name="turnadoInterno" id="turnadoInterno" value="Yadira Ocampo Bautista" checked="false"/>Yadira Ocampo Bautista
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'turnadoInterno', 'error')} ">
     <label for="turnadoInterno">
        <g:message code="documento.turnadoInterno.label" default="" />
    </label>
    <g:checkBox name="turnadoInterno" id="turnadoInterno" value="Lic. Paulina Toledo Couret" checked="false"/>Lic. Paulina Toledo Couret
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'turnadoInterno', 'error')} ">
     <label for="turnadoInterno">
        <g:message code="documento.turnadoInterno.label" default="" />
    </label>
    <g:checkBox name="turnadoInterno" id="turnadoInterno" value="Relaciones Públicas" checked="false"/>Relaciones Públicas
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'turnadoInterno', 'error')} ">
     <label for="turnadoInterno">
        <g:message code="documento.turnadoInterno.label" default="" />
    </label>
    <g:checkBox name="turnadoInterno" id="turnadoInterno" value="Elvira Chong" checked="false"/>Elvira Chong
</div>
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'turnadoInterno', 'error')} ">
     <label for="turnadoInterno">
        <g:message code="documento.turnadoInterno.label" default="" />
    </label>
    <g:checkBox name="turnadoInterno" id="turnadoInterno" value="Lic. César Rodríguez Chávez" checked="false"/>Lic. César Rodríguez Chávez 
</div> 
<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'turnadoInterno', 'error')} ">
     <label for="turnadoInterno">
        <g:message code="documento.turnadoInterno.label" default="" />
    </label>
    <g:checkBox name="turnadoInterno" id="turnadoInterno" value="Mabel García Alpízar" checked="false"/>Mabel García Alpízar
</div> 


