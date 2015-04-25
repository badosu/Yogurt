class Yogurt
  route 'communities' do |r|
    set_view_subdir 'communities'

    r.is do
      r.get do
        @communities = Community.order(Sequel.desc(:created_at)).all

        :index
      end

      r.post do
        fields = %w[name description private]
        @community = Community.new.set_fields(r.params, fields)

        if @community.save
          r.redirect '/communities'
        else
          :new
        end
      end
    end

    r.get 'new' do
      @community = Community.new

      :new
    end

    r.on :id do |id|
      @community = Community.with_pk!(id.to_i)

      r.get('edit') { :edit }

      r.is do
        r.put do
          fields = %w[name description private]

          if @community.update_fields(r.params, fields)
            r.redirect '/communities'
          else
            :edit
          end
        end

        r.delete do
          @community.delete

          r.redirect '/communities'
        end
      end
    end
  end
end
