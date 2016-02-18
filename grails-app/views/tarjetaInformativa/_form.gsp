
<g:javascript>   
$('#nombreRemitente').keyup(function() {
    var tamano = document.getElementById('nombreRemitente').value;
    var t = tamano.length
    var intValue = parseInt(t);
    if(intValue >= 2){

    $.ajax({
    url: '/SGC/tarjetaInformativa/buscadorAjax/',  
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


<g:if test="${tarjetaInformativaInstance?.remitente}">
    <li class="fieldcontain">
        <span id="remitente-label" class="property-label"><g:message code="tarjetaInformativa.remitente.label" default="Remitente" /></span>

        <span class="property-value" aria-labelledby="remitente-label">${tarjetaInformativaInstance?.remitente?.encodeAsHTML()}</span>

    </li>
    <g:hiddenField name="remitentePer" value="${tarjetaInformativaInstance.remitente}" />
</g:if>

 <div class="fieldcontain ${hasErrors(bean: tarjetaInformativaInstance, field: 'tarjetaInformativa', 'error')} ">
        <label for="remitente">
          <g:message code="tarjetaInformativa.remitente.label" default="Nombre" />

        </label>
        <g:textField name="nombreRemitente" id="nombreRemitente"  maxlength="210" value="" onkeyup="" size="20px"/>  
  </div>
<div class="fieldcontain ${hasErrors(bean: tarjetaInformativaInstance, field: 'documentos', 'error')} ">
        <label for="remitentes">
          <g:message code="tarjetaInformativa.remitente.label" default="Remitentes" />

        </label>
        <g:select id="id_Remitente" name="remitente.id" from="" multiple="multiple" optionKey="id" size="5" value="${tarjetaInformativaInstance?.remitente*.id}" class="many-to-many" style=" width: 450px"/>
        <a href="JavaScript:newPopup('${createLink(controller: 'Persona',action:"create")}')"><img src="${resource(dir: 'images', file: 'remitent.png')}"/></a>            
  </div>

<div class="fieldcontain ${hasErrors(bean: tarjetaInformativaInstance, field: 'asunto', 'error')} required">
	<label for="asunto">
		<g:message code="tarjetaInformativa.asunto.label" default="Asunto" />
		<span class="required-indicator">*</span>
	</label>
	
	<g:textArea name="asunto" required="" value="${tarjetaInformativaInstance?.asunto}" id="resizable"/>
</div>

