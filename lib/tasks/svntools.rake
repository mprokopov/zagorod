desc "Рекурсивно пройдется по дереву проекта и добавит недобавленные"
task :add_all_to_svn do
`svn status --show-updates`.each { |l|
  l = l.split
  system("svn add #{l.last}") if l.first == "?"
}
end
