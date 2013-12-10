task(:README) { sh 'bin/casher --help > README' }
task(:spec) { ruby '-S rspec' }
task(default: [:spec, :README])
