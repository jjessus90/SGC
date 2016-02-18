



<div class="fieldcontain ${hasErrors(bean: turnadoTarjetaInstance, field: 'dependencia', 'error')} required">
	<label for="dependencia">
		<g:message code="turnadoTarjeta.dependencia.label" default="Dependencia" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="dependencia" name="dependencia.id" from="${Dependencia.list()}" optionKey="id" required="" value="${turnadoTarjetaInstance?.dependencia?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: turnadoTarjetaInstance, field: 'usuarioSistema', 'error')} required">
	<label for="usuarioSistema">
		<g:message code="turnadoTarjeta.usuarioSistema.label" default="Usuario Sistema" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="usuarioSistema" name="usuarioSistema.id" from="${UsuarioSistema.list()}" optionKey="id" required="" value="${turnadoTarjetaInstance?.usuarioSistema?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: turnadoTarjetaInstance, field: 'tarjetaInformativa', 'error')} required">
	<label for="tarjetaInformativa">
		<g:message code="turnadoTarjeta.tarjetaInformativa.label" default="Tarjeta Informativa" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="tarjetaInformativa" name="tarjetaInformativa.id" from="${TarjetaInformativa.list()}" optionKey="id" required="" value="${turnadoTarjetaInstance?.tarjetaInformativa?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: turnadoTarjetaInstance, field: 'fechaTurnado', 'error')} required">
	<label for="fechaTurnado">
		<g:message code="turnadoTarjeta.fechaTurnado.label" default="Fecha Turnado" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fechaTurnado" precision="day"  value="${turnadoTarjetaInstance?.fechaTurnado}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: turnadoTarjetaInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="turnadoTarjeta.status.label" default="Status" />
		
	</label>
	<g:checkBox name="status" value="${turnadoTarjetaInstance?.status}" />
</div>

<div class="fieldcontain ${hasErrors(bean: turnadoTarjetaInstance, field: 'persona', 'error')} required">
	<label for="persona">
		<g:message code="turnadoTarjeta.persona.label" default="Persona" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="persona" name="persona.id" from="${Persona.list()}" optionKey="id" required="" value="${turnadoTarjetaInstance?.persona?.id}" class="many-to-one"/>
</div>

