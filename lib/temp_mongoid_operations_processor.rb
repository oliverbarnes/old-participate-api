# FIXME: hack to get mongoid working on JR again, mongoid support is in flux
class TempMongoidOperationsProcessor < JSONAPI::OperationsProcessor

  private

    def process_operation(operation)
      with_default_handling do
        begin
          operation.apply
        rescue Mongoid::Errors::DocumentNotFound
          record_not_found = JSONAPI::Exceptions::RecordNotFound.new(operation.associated_key)
          return JSONAPI::ErrorsOperationResult.new(record_not_found.errors[0].code, record_not_found.errors)
        end
      end
    end
end
