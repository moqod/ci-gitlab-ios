#### Description: runs linting and other tools in parallel to static analyze

# perform taior analyze
sh ci/reports/tailor/tailor.sh

# find code duplications
sh ci/reports/jscpd/jscpd.sh

# copy files into public folder
