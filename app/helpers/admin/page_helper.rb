module Admin::PageHelper
	def sidebar
		render_partial('sidebar')
	end
def submit_to_preview(name, value, options = {})
    options[:with] ||= 'Form.serialize(this.form)'

    options[:html] ||= {}
         options[:html][:type] = 'button'
         options[:html][:onclick] = "updatePreview();#{remote_function(options)}; return false;"
         options[:html][:name] = name
         options[:html][:value] = value

         tag("input", options[:html], false)
  end
end
