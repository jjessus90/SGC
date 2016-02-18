

import org.junit.*
import grails.test.mixin.*

@TestFor(ClasificacionArchivoController)
@Mock(ClasificacionArchivo)
class ClasificacionArchivoControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/clasificacionArchivo/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.clasificacionArchivoInstanceList.size() == 0
        assert model.clasificacionArchivoInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.clasificacionArchivoInstance != null
    }

    void testSave() {
        controller.save()

        assert model.clasificacionArchivoInstance != null
        assert view == '/clasificacionArchivo/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/clasificacionArchivo/show/1'
        assert controller.flash.message != null
        assert ClasificacionArchivo.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/clasificacionArchivo/list'

        populateValidParams(params)
        def clasificacionArchivo = new ClasificacionArchivo(params)

        assert clasificacionArchivo.save() != null

        params.id = clasificacionArchivo.id

        def model = controller.show()

        assert model.clasificacionArchivoInstance == clasificacionArchivo
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/clasificacionArchivo/list'

        populateValidParams(params)
        def clasificacionArchivo = new ClasificacionArchivo(params)

        assert clasificacionArchivo.save() != null

        params.id = clasificacionArchivo.id

        def model = controller.edit()

        assert model.clasificacionArchivoInstance == clasificacionArchivo
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/clasificacionArchivo/list'

        response.reset()

        populateValidParams(params)
        def clasificacionArchivo = new ClasificacionArchivo(params)

        assert clasificacionArchivo.save() != null

        // test invalid parameters in update
        params.id = clasificacionArchivo.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/clasificacionArchivo/edit"
        assert model.clasificacionArchivoInstance != null

        clasificacionArchivo.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/clasificacionArchivo/show/$clasificacionArchivo.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        clasificacionArchivo.clearErrors()

        populateValidParams(params)
        params.id = clasificacionArchivo.id
        params.version = -1
        controller.update()

        assert view == "/clasificacionArchivo/edit"
        assert model.clasificacionArchivoInstance != null
        assert model.clasificacionArchivoInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/clasificacionArchivo/list'

        response.reset()

        populateValidParams(params)
        def clasificacionArchivo = new ClasificacionArchivo(params)

        assert clasificacionArchivo.save() != null
        assert ClasificacionArchivo.count() == 1

        params.id = clasificacionArchivo.id

        controller.delete()

        assert ClasificacionArchivo.count() == 0
        assert ClasificacionArchivo.get(clasificacionArchivo.id) == null
        assert response.redirectedUrl == '/clasificacionArchivo/list'
    }
}
