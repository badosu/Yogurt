class Yogurt
  route 'communities' do |r|
    set_view_subdir 'communities'

    r.is do
      @communities = Community.order(Sequel.desc(:created_at)).all

      :index
    end

    r.is 'new' do
      @community = Community.new

      r.get do
        :new
      end

      r.post do
        @community.set_fields(r.params, %w[name description private])

        if @community.save
          r.redirect '/communities'
        else
          :new
        end
      end
    end

    r.on ':id' do |id|
      @community = Community.with_pk!(id.to_i)

      r.get('edit') { :edit }

      r.put do
        @community.set_fields(r.params, %w[name description private])

        if @community.save
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
