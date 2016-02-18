



<div class="fieldcontain ${hasErrors(bean: clasificacionArchivoInstance, field: 'dependencia', 'error')}  ">
	<label for="dependencia">
		<g:message code="clasificacionArchivo.dependencia.label" default="Dependencia" />
		
	</label>
	<g:textField name="dependencia" value="${clasificacionArchivoInstance?.dependencia}"style=" width: 400px"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clasificacionArchivoInstance, field: 'tipoDependencia', 'error')} ">
	<label for="tipoDependencia">
		<g:message code="clasificacionArchivo.tipoDependencia.label" default="Tipo Dependencia" />
		
	</label>
	<g:select name="tipoDependencia" from="${clasificacionArchivoInstance.constraints.tipoDependencia.inList}" value="${clasificacionArchivoInstance?.tipoDependencia}" valueMessagePrefix="clasificacionArchivo.tipoDependencia" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clasificacionArchivoInstance, field: 'clave', 'error')} ">
	<label for="clave">
		<g:message code="clasificacionArchivo.clave.label" default="Clave" />
		
	</label>
	<g:textField name="clave" value="${clasificacionArchivoInstance?.clave}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clasificacionArchivoInstance, field: 'anio', 'error')} required">
	<label for="anio">
		<g:message code="clasificacionArchivo.anio.label" default="Año" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="anio" precision="year"  value="${clasificacionArchivoInstance?.anio}"/>
</div>

