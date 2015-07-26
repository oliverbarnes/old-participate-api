# FIXME: hack to get mongoid working on JR again, mongoid support is in flux
class TempMongoidOperationsProcessor < JSONAPI::OperationsProcessor

  private

    def transaction
      # if @transactional
      #   ActiveRecord::Base.transaction do
      #     yield
      #   end
      # else
      yield
      # end
    end

    def rollback
      # raise ActiveRecord::Rollback if @transactional
    end

    def process_operation(operation)
      # operation.apply(@context)
      operation.apply
    # rescue ActiveRecord::DeleteRestrictionError => e
    #   record_locked_error = JSONAPI::Exceptions::RecordLocked.new(e.message)
    #   return JSONAPI::ErrorsOperationResult.new(record_locked_error.errors[0].code, record_locked_error.errors)

    rescue Mongoid::Errors::DocumentNotFound
      record_not_found = JSONAPI::Exceptions::RecordNotFound.new(operation.associated_key)
      return JSONAPI::ErrorsOperationResult.new(record_not_found.errors[0].code, record_not_found.errors)
    end
end
