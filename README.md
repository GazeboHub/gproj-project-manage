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

This item represents the primary _use case_ for the gproj-project-manage
components.

Projects under which this usage scenario may be developed:

* gproj-ghub-site-manage
    * A submodule shall represent the published contents of the
      `gazebohub.github.io` web site
    * (Configuration One) The gproj-project-manage source tree may be used as a submodule, for purpose of ensuring availability of shared resources provided in gproj-project-manage
* portal-gproj-manage
    * A submodule shall represent the `portal-gproj` [OpenShift][oso]
      application, in its current design iteration
    * (Configuration One) The gproj-project-manage source tree may be used as a submodule, likewise

In a criticism of this proposed _Configuration One_: For a workspace in which _both of_ the gproj-ghub-site-manage and portal-gproj-manage source trees would be under development, in parallel, the use of the gproj-project-manage source tree as a submodule of both projects would, in turn, result in a duplication of the gproj-project-manage source tree, within that workspace. Transitively, the duplication may result in some added tedium within the workflow of the _containing project_. It would be desirable that such tedium would be avoided.

An alternate model may be developed, in which a project `P` would be defined, such that `P` would have as submodule, all of:

* gproj-project-manage
* gproj-ghub-site-manage
* portal-gproj-manage

In this alternate model, the gproj-project-manage source tree _would not be_ defined as a submodule of the set of the latter two components but rather, as a submodule of `P`, such that the projects in the latter set would each be a submodule of, likewise. In criticism of this alternate model, some matters of minor inconvenience may be introduced noetheless:

* The gproj-project-manage source tree would then not be avilable as a submodule of the other two projects. If either of those projects' source trees would be _cloned_ individually, then any functionality provided by components in gproj-project-manage (e.g submodule commit check) must then be retrieved seperately, or would be unabailable.
* Considering that each of the latter set of projects' source trees, in itself, shall use a submodule, this alternate configuration may lend some additional complexity to the overall source tree configuration, at least under project `P`


Each of those concerns may represent a matter of minor inconvenience, having no further, apparent technical ramifications onto the containing project. 

* In regards to the first item, the gproj-project-manage source tree may be retrieved seperately. Any functionality it may provide may be installed from there.
* In regards to the second matter, this alternate configuration - namely, in developing a new source tree, `P` - this alternate configuration  may applied tentatively, so as to verify whether the _"nested submodules" configuration may pose any technical concern with regards to the operations of the `check-submodules.sh` Git 'update' hook, or any other hooks provided in gproj-project-manage

Pending a successful application of this alternate configuration, as from a point of view with regards to GProj web resource management, this alternate configuration may represent a _"preferred configuration"_, as contrasted to the first configuration presented, in the above.

It's planned that project `P` will be named gproj-web-workspace.

In something of an academic comment about this design: From a _component modeling_ standpoint, this _alternate configuration_ introduces a _workspace model_ into the _SCCM information space_, as may resemble a _resource model_ in the _IDE information space_ - specifically, as with regards to a _workspace_ paradigm reified in the [Eclipse IDE](http://www.eclipse.org/). Furthermore, a _resource model_ of type _workspace_ is reified alternately, within the JCR content modeling framework, as in [JSR-283](https://jcp.org/en/jsr/detail?id=283). With regards to models for _distributed workspaces_ and _distributed development_, broadly, perhaps this abstract similarity of models _may bear some further consideration_, as towards practical concerns with regards to overall _content development tooling_ and innovations in _content management systems development_. 


## Availability

* [gproj-project-manage source repository][src]


[src]: https://github.com/GazeboHub/gproj-project-manage
[oso]: https://www.openshift.com/
