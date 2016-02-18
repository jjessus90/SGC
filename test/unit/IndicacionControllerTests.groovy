

import org.junit.*
import grails.test.mixin.*

@TestFor(IndicacionController)
@Mock(Indicacion)
class IndicacionControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/indicacion/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.indicacionInstanceList.size() == 0
        assert model.indicacionInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.indicacionInstance != null
    }

    void testSave() {
        controller.save()

        assert model.indicacionInstance != null
        assert view == '/indicacion/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/indicacion/show/1'
        assert controller.flash.message != null
        assert Indicacion.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/indicacion/list'

        populateValidParams(params)
        def indicacion = new Indicacion(params)

        assert indicacion.save() != null

        params.id = indicacion.id

        def model = controller.show()

        assert model.indicacionInstance == indicacion
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/indicacion/list'

        populateValidParams(params)
        def indicacion = new Indicacion(params)

        assert indicacion.save() != null

        params.id = indicacion.id

        def model = controller.edit()

        assert model.indicacionInstance == indicacion
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/indicacion/list'

        response.reset()

        populateValidParams(params)
        def indicacion = new Indicacion(params)

        assert indicacion.save() != null

        // test invalid parameters in update
        params.id = indicacion.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/indicacion/edit"
        assert model.indicacionInstance != null

        indicacion.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/indicacion/show/$indicacion.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        indicacion.clearErrors()

        populateValidParams(params)
        params.id = indicacion.id
        params.version = -1
        controller.update()

        assert view == "/indicacion/edit"
        assert model.indicacionInstance != null
        assert model.indicacionInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/indicacion/list'

        response.reset()

        populateValidParams(params)
        def indicacion = new Indicacion(params)

        assert indicacion.save() != null
        assert Indicacion.count() == 1

        params.id = indicacion.id

        controller.delete()

        assert Indicacion.count() == 0
        assert Indicacion.get(indicacion.id) == null
        assert response.redirectedUrl == '/indicacion/list'
    }
}
