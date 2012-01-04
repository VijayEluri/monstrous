# Generated by Buildr 1.4.3, change to your liking
# Version number for this release
VERSION_NUMBER = "0.0.2"
# Group identifier for your projects
GROUP = "monstrous"
COPYRIGHT = ""

# Specify Maven 2.0 remote repositories here, like this:
repositories.remote << "http://mirrors.ibiblio.org/pub/mirrors/maven2"

require 'buildfile_libraries'

JARS = artifacts([ HTTPCLIENT, JSON_LIB, JETTY, LOGGING ].flatten.uniq)

desc "The Monstrous project"
define "monstrous" do

  project.version = VERSION_NUMBER
  project.group = GROUP
  manifest["Implementation-Vendor"] = COPYRIGHT

  eclipse.natures :java

  compile.with JARS

  package(:jar)

  package(:zip).path("#{project.name}-#{VERSION_NUMBER}").tap do |path|
    path.include _("bin/*")
  end

  package(:zip).path("#{project.name}-#{VERSION_NUMBER}/lib").tap do |path|
    path.include _("target/#{project.name}-#{VERSION_NUMBER}.jar")
    compile.dependencies.each do |d|
      path.include _("#{d}")
    end
  end

end
