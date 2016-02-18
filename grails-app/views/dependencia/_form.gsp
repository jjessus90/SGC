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



<div class="fieldcontain ${hasErrors(bean: dependenciaInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="dependencia.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" required="" value="${dependenciaInstance?.nombre}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dependenciaInstance, field: 'calleNumero', 'error')}">
	<label for="calleNumero">
		<g:message code="dependencia.calleNumero.label" default="Calle Numero" />
		
	</label>
	<g:textField name="calleNumero"value="${dependenciaInstance?.calleNumero}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dependenciaInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="dependencia.status.label" default="Status" />
		
	</label>
	<g:checkBox name="status" value="${dependenciaInstance?.status}" />
</div>

<div class="fieldcontain ${hasErrors(bean: dependenciaInstance, field: 'estado', 'error')} required">
    <label for="estado">
    <g:message code="dependencia.estado.label" default="Estado" />
    <span class="required-indicator">*</span>
    </label>
    <g:select id="estado" name="estado.id"  from="${Estado.list()}" onchange="cargaMunicipios()" required="Selecciona un elemento de la lista" optionKey="id" style="width: 600px" noSelection="${['':'Seleccione...']}" value="${dependenciaInstance?.estado?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dependenciaInstance, field: 'municipio', 'error')}">
    <label for="municipio">
    <g:message code="documento.estado.label" default="Municipio:" />    
    </label>
    <g:select id="municipio" name="municipio.id"  from="" noSelection="${['null':'Seleccione...']}" style=" width: 600px" optionKey="id" value="${dependenciaInstance?.municipio?.id}" class="many-to-one"/>
    
</div>

<div class="fieldcontain ${hasErrors(bean: dependenciaInstance, field: 'colonia', 'error')}">
	<label for="colonia">
		<g:message code="dependencia.colonia.label" default="Colonia" />
		
	</label>
	<g:textField name="colonia" value="${dependenciaInstance?.colonia}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dependenciaInstance, field: 'cp', 'error')}">
	<label for="cp">
		<g:message code="dependencia.cp.label" default="Cp" />
		
	</label>
	<g:field name="cp" type="number" value="${dependenciaInstance.cp}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dependenciaInstance, field: 'tipoDependencia', 'error')} ">
	<label for="tipoDependencia">
		<g:message code="dependencia.tipoDependencia.label" default="Tipo Dependencia" />
		
	</label>
	<g:select name="tipoDependencia" from="${dependenciaInstance.constraints.tipoDependencia.inList}" value="${dependenciaInstance?.tipoDependencia}" valueMessagePrefix="dependencia.tipoDependencia" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dependenciaInstance, field: 'turnados', 'error')} ">
	<label for="turnados">
		<g:message code="dependencia.turnados.label" default="Turnados" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${dependenciaInstance?.turnados?}" var="t">
    <li><g:link controller="turnado" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="turnado" action="create" params="['dependencia.id': dependenciaInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'turnado.label', default: 'Turnado')])}</g:link>
</li>
</ul>

</div>

