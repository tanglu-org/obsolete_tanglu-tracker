module ProjectsTable
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :render_project_hierarchy, :projects_table
    end
  end

  module InstanceMethods
    def render_project_hierarchy_with_projects_table(projects)
      tlprojects = Rails.cache.fetch('pt_projects_toplevel', :expires_in => 24.hours) { projects.select { |p| p.level == 0 } }
      render('table', :projects => tlprojects.sort_by(&:lft))
    end
  end
end
