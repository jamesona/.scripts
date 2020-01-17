// process arguments
const [,,version, path] = process.argv

if (!version) {
	return console.error('No version number supplied')
} else if (!path) {
	return console.error('Unable to determine working path')
}

// check for package file
const packageJSON = require(`${path}/package.json`)

if (!packageJSON) {
	return console.error('Unable to find package.json')
}

// check for repo details
const [, owner, repository] = packageJSON.repository.url
	.replace(/^git:\/\/|\.git$/g, '')
	.split('/')

if (!owner) {
	return console.error('Unable to determine repository owner')
} else if (!repository) {
	return console.error('Unable to determine repository name')
}


// check for version file
const fs = require('fs')
const versionFile = `${path}/changelog/${version}.json`

if (!fs.existsSync(versionFile)) {
	return console.error('Unable to find target version file')
}

// read version file
const versionBuffer = fs.readFileSync(versionFile, 'utf8')
const versionData = JSON.parse(versionBuffer)
const versionCheckErrors = ['version', 'hash', 'date', 'features', 'issues'].map(key => {
	if (versionData[key] === undefined) {
		return Error(`Version file is missing key "${key}"`)
	}
})

const Git = require('nodegit')

function publish() {
	Git.Remote.create(
		repository,
		'origin',
		`git@github.com:${owner}/${repository}.git`
	).then(remote =>
		remote.push([`refs/tags/${version}`], {
			callbacks: {
				credentials: function(url, username) {
					return Git.Cred.sshKeyFromAgent('jamesona')
				}
			}
		})
	)
}
