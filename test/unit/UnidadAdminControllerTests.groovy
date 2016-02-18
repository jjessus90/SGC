

import org.junit.*
import grails.test.mixin.*

@TestFor(UnidadAdminController)
@Mock(UnidadAdmin)
class UnidadAdminControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/unidadAdmin/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.unidadAdminInstanceList.size() == 0
        assert model.unidadAdminInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.unidadAdminInstance != null
    }

    void testSave() {
        controller.save()

        assert model.unidadAdminInstance != null
        assert view == '/unidadAdmin/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/unidadAdmin/show/1'
        assert controller.flash.message != null
        assert UnidadAdmin.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/unidadAdmin/list'

        populateValidParams(params)
        def unidadAdmin = new UnidadAdmin(params)

        assert unidadAdmin.save() != null

        params.id = unidadAdmin.id

        def model = controller.show()

        assert model.unidadAdminInstance == unidadAdmin
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/unidadAdmin/list'

        populateValidParams(params)
        def unidadAdmin = new UnidadAdmin(params)

        assert unidadAdmin.save() != null

        params.id = unidadAdmin.id

        def model = controller.edit()

        assert model.unidadAdminInstance == unidadAdmin
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/unidadAdmin/list'

        response.reset()

        populateValidParams(params)
        def unidadAdmin = new UnidadAdmin(params)

        assert unidadAdmin.save() != null

        // test invalid parameters in update
        params.id = unidadAdmin.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/unidadAdmin/edit"
        assert model.unidadAdminInstance != null

        unidadAdmin.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/unidadAdmin/show/$unidadAdmin.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        unidadAdmin.clearErrors()

        populateValidParams(params)
        params.id = unidadAdmin.id
        params.version = -1
        controller.update()

        assert view == "/unidadAdmin/edit"
        assert model.unidadAdminInstance != null
        assert model.unidadAdminInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/unidadAdmin/list'

        response.reset()

        populateValidParams(params)
        def unidadAdmin = new UnidadAdmin(params)

        assert unidadAdmin.save() != null
        assert UnidadAdmin.count() == 1

        params.id = unidadAdmin.id

        controller.delete()

        assert UnidadAdmin.count() == 0
        assert UnidadAdmin.get(unidadAdmin.id) == null
        assert response.redirectedUrl == '/unidadAdmin/list'
    }
}
