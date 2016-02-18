<g:javascript> 
 /*Carga municipios*/

    function cargaMunicipios(){
   
        $.ajax({
            url: '/SGC/Persona/ajaxGetMunicipio/',  
            method: 'GET',
            data:{id:document.getElementById('estado').value},
            success: function(objeto){             
        /**/
            if (objeto) {
                var rselect = document.getElementById('municipio')

                // Clear all previous options 
                var l = rselect.length
                while (l > 0) {
                    l-- 
                    rselect.remove(l) 
                }

                if(1 > objeto.length){
                    alert('No hay municipios registrados para este Estado')
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
<g:javascript>   
    $('#nombreDependencia').keyup(function() {
    var tamano = document.getElementById('nombreDependencia').value;
    var t = tamano.length
    var intValue = parseInt(t);
    if(intValue >= 2){

    $.ajax({
    url: '<%=request.getContextPath()%>'+'/persona/buscadorAjaxDependencias/',  
    method: 'GET',
    data:{id:document.getElementById('nombreDependencia').value},
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
<script>
    
    function newPopup(url) {
	popupWindow = window.open(
		url,'popUpWindow','height=700,width=1000,left=200,top=10,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=yes')
    }
</script>

<div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'nombre', 'error')} required ">
	<label for="nombre">
		<g:message code="persona.nombre.label" default="Nombre" />
		
	</label>
	<g:textField name="nombre" required="true" value="${personaInstance?.nombre}" required="Es necesario ingresar nombre" size="40px"/>
</div>

<div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'cargo', 'error')} ">
	<label for="cargo">
		<g:message code="persona.cargo.label" default="Cargo" />
		
	</label>
	<g:textField name="cargo" value="${personaInstance?.cargo}" size="40px"/>
</div>

<div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'correo', 'error')} ">
	<label for="correo">
		<g:message code="persona.correo.label" default="Correo" />
		
	</label>
	<g:textField name="correo" value="${personaInstance?.correo}" size="40px"/>
</div>

<div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'calleNumero', 'error')} ">
	<label for="calleNumero">
		<g:message code="persona.calleNumero.label" default="Calle Numero" />
		
	</label>
	<g:textField name="calleNumero" value="${personaInstance?.calleNumero}" size="40px"/>
</div>



<div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'colonia', 'error')} ">
	<label for="colonia">
		<g:message code="persona.colonia.label" default="Colonia" />
		
	</label>
	<g:textField name="colonia" value="${personaInstance?.colonia}" size="40px"/>
</div>

<div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'cp', 'error')} ">
	<label for="cp">
		<g:message code="persona.cp.label" default="Cp" />
		<!--<span class="required-indicator">*</span>-->
	</label>
	<g:field name="cp" type="number" value="${personaInstance.cp}" maxlength="5"/>
</div>

<div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'tel', 'error')}">
	<label for="tel">
		<g:message code="persona.tel.label" default="Telefono" />
		<!--<span class="required-indicator">*</span>-->
	</label>
	<g:field name="tel" type="number" value="${personaInstance.tel}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'persona', 'error')} ">
    <label for="dependencias">
        <g:message code="persona.dependencia.label" default="Dependencia" />
    </label>
    <g:textField name="nombreDependencia" id="nombreDependencia" placeholder="Escribe la Dependencia"  maxlength="210" value="" onkeyup="" size="20px"/>

</div>
<div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'persona', 'error')} ">
    <label for="nombreDependencia">
        <g:message code="persona.dependencia.label" default="Dependencias" />
    </label>
    <g:select id="id_Dependencia" name="dependencia.id" from="" multiple="multiple" optionKey="id" size="5" value="${personaInstance?.dependencia*.id}" class="many-to-many" style=" width: 450px"/>
    <a href="JavaScript:newPopup('${createLink(controller: 'Dependencia',action:"create")}')"><img src="${resource(dir: 'images', file: 'dependencia.png')}"/></a>    
</div>


<div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'estado', 'error')} required ">
    <label for="estado">
    <g:message code="persona.estado.label" default="Estado" />
    <span class="required-indicator">*</span>
    </label>
    <g:select id="estado" name="estado.id"  from="${Estado.list()}" onchange="cargaMunicipios()" required="" optionKey="id" required="Seleccionar un elemento de la lista" style="width: 600px" noSelection="${['':'Seleccione...']}" value="${personaInstance?.estado?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'municipio', 'error')}">
    <label for="municipio">
    <g:message code="documento.estado.label" default="Municipio:" />
    </label>
    <g:select id="municipio" name="municipio.id"  from="" noSelection="${[' ':'Seleccione...']}" style=" width: 600px" optionKey="id" value="${usuarioSistemaInstance?.municipio?.id}" class="many-to-one"/>
    
</div>





