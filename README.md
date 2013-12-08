gproj-project-manage
====================

Project management resources shared among GProj projects

## Usage

### Git Hooks

The directory `src/main/resources/git/hooks/` contains files for use
within a source tree's `.git/hooks/` directory. Each of those files is
documented in commentary in the respective file.

### Eclipse IDE External Tools Configurations

(To Do)

### Using this source tree as a submodule of other GProj component source trees

This represents the primary _use case_ for the gproj-project-manage
components.

Projects under which this usage scenario may be developed:

* gproj-ghub-site-manage
    * a submodule shall represent the published contents of the
      `gazebohub.github.io` web site
* portal-gproj-manage
    * a submodule shall represent the `portal-gproj` [OpenShift][oso]
      application, in its current design iteration


## Availability

* [gproj-project-manage source repository][src]


[src]: https://github.com/GazeboHub/gproj-project-manage
[oso]: https://www.openshift.com/
