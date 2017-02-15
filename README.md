##Assignment: Module #3 - Testing

####Objective

By the end of this assignment, you will be able to:
• Create a FactoryGirl factory for a model class
• Create an RSpec Request Spec for API testing to re-create a reported error and verify the correction
• Create a Capybara Feature Spec for Javascript, Web UI testing to re-create a reported error and (optional) verify
  the correction
• Implement better exception/error handling in the resource API
• (optional) Implement button enable/disable rules based on the validity of a form
• Verify the error correction using the same RSpec tests

####Requirements (110-135 min)

The work in this assignment must be done against the version of the example repository marked by the git tag
testing-assignment (i.e., checkout and develop against that tag). Submit the solution with this assignment. Submit
only the files modified an effort to limit the number of files created for simpler assignment submission and grading. Do
not submit a pull request to Github with the solution.

1. (15 min) Create a new default FactoryGirl factory for the Foo model that replaces the dynamic names generated
	for Foo#name by Faker. Your new factory must return names in the form of name0, name1, name2, for each time
	it is called and return to name0 after reaching name9.

2. (30 min) The scaffold-generated Foo#create controller method continues to have issues with its error handling
	and reporting. For example, if we POST the following content, an ActiveRecord::StatementInvalid exception
	is thrown and we likely get a 500/Internal Server Error and an HTML page.
	:foo=>{:id=>1}
	In this step, you are to write a test that exposes this or a separate error with the Foo#create method. The code
	must be developed against the version marked by the git tag testing-assignment (i.e., checkout and develop
	against that tag). The failing test must have a name/comment "invalid Foo reports API error".
	A successful execution of the method with the erroneous inputs is a 4xx error message (e.g., 400/Bad Request or
	422/Unprocessable Entity) with a JSON payload containing error information consistent with the following
	example format:
	{"errors"=>
	{"field_name1"=>["error1","error2"],
	"field_name2"=>["error1"],
	"full_messages"=>
	["field_name1 error1",
	"field_name1 error2",
	"field_name2 error1]}}
	Note: Portions of the above format is consistent with the output of ActiveRecord validation error.messages.
	Lacking a specific field in error – the payload will just have errors.full_messages[]
3. (30 min) Correct the error with the Foo#create controller method and API response you re-created by making
	updates to source files in the app directory. The solution can include error checking, ActiveRecord model
	validation, rescue clauses, etc. The corrected version must pass the RSpec Request Spec developed in the previous
	requirement. We are fundamentally looking for detection and reporting of the error condition using a rendered
	JSON payload and status code versus throwing an exception.
4. (30 min) The Foo form in the Foo AngularJS UI has a Create Foo button that is displayed when the current
	instance does not have an id. However, name is required to be filled in before the form can be submitted. Write a
	Capybara Feature test labelled "Create button disabled when no name", for Foo that checks that the visible
	Create Foo button is disabled when the name field is blank. The successful spec will detect the condition when
	run against the targeted baseline.

5. This requirement has two options
	• Option A: (5 min) Create a second version of the Foo Capybara Feature Spec that marks the failing test
	from above as pending – such that it is required to fail in order to stay in the pending state.
	• Option B: (30 min) Correct the issue with the enabled Create Foo button detected by your Foo Capybara
	Feature Spec. This should be limited to a change to only the HTML file. We did not cover this topic in the
	lectures but it will come up later in the course and may be fun to work with now. If the form has is assigned
	a legal name attribute, AngularJS will populate a property by that name in the scope with information
	about the form – whether it is $dirty, $invalid, etc. AngularJS also has a ng-disabled directive that
	can be applied to a button and set to the value of the formName.$invalid form property to toggle it from
	the disabled and enabled state based on each of the state of the fields in the form. The corrected version
	must pass the Capybara Feature Spec developed in the previous requirement. We are fundamentally looking
	for the Create Foo button to only be enabled when the form contains all required information.
	At the successful completion of this requirement, your original Capybara Feature Spec should either be pending/
	yellow (because the error is still occuring) or passing/green (because you have chosen to spend the extra time
	to fix the error).
	
####Submission

1. Supply a git patch file that contains a single commit with all spec file (factories, requests, and features) changes
	you have made since checking out the course’s testing-assignment git tag. These changes should contain
	artifacts that help test and identify issues with the version of the Foo example.
2. Supply a git patch file that contains a single commit with all of the app and spec/features file (models,
	controllers, assets, pending specs) changes that you made from the course’s testing-assignment git tag and
	testing.patch. These files should contain artifacts that correct issues found with the version of the Foo example.
	
####Submisson References
• Combining multiple commits before pushing in Git
• How to create and apply a patch with Git
• Git format-patch documentation

####Creating Submission

You are going to submit two Git patch files – one with all tests to identify the errors and one with all solutions to
either fix or mark error(s) pending. If you make multiple local commits in either of those two groupings, you must
squash the individual commits into a single commit to submit a single .patch file.

1. Create a working area of the class examples using the required tag.
	$ git clone https://github.com/jhu-ep-coursera/capstone_demoapp --branch testing-assignment
	$ cd capstone-examples-lecture
2. Create a new branch for your testing changes
	$ git checkout -b testing
3. Make your testing changes
	$ rails g rspec:request FooApiErrorReporting
	create spec/requests/foo_api_error_reportings_spec.rb
4. Commit your changes to your branch
	$ git add spec/
	$ git commit -m "added assignment tests"
5. Create a patch for the testing changes. It should not include any application changes. This file will be submitted
	with the assignment.
	$ git format-patch testing-assignment
	0001-added-assignment-tests.patch
6. Repeat the steps above for the solution changes, but should be from the testing patch forward. This file will also
	be submitted with the assignment.
	$ echo "#fixed something" >> app/models/foo.rb
	$ echo "#fixed something" >> app/controllers/foos_controller.rb
	$ echo "#fixed something" >> app/controllers/application_controller.rb
	$ sed s/foo_api_error_reportings_path/foos_path/g spec/requests/foo_api_error_reportings_spec.rb > spec/$ git add -A
	$ git commit -m "added application solutions"
	$ git format-patch testing-assignment
	0001-added-assignment-tests.patch
	0002-added-application-solutions.patch # submit this file

####Grading Submission

1. Create a working area of the class examples using the required tag.
	$ git clone https://github.com/jhu-ep-coursera/capstone_demoapp --branch testing-assignment
	$ cd capstone-examples-lecture
2. Inspect the contents of the patch
	$ git apply --stat ../0001-added-assignment-tests.patch
	spec/features/foo_ui_buttons_spec.rb | 5 +++++
	spec/requests/foo_api_error_reportings_spec.rb | 10 ++++++++++
	2 files changed, 15 insertions(+)
3. Verify the submitted test patch can be applied without Git errors. Report any errors to the author and stop
	grading at this point.
	$ git apply --check ../0001-added-assignment-tests.patch
4. Apply submitted testing changes to your new repository clone.
	$ git am --signoff < ../0001-added-assignment-tests.patch
	Applying: added assignment tests
5. Inspect/test the specs
	$ bundle exec rspec
6. Repeat the steps above for the solution changes, but should be from the testing patch forward.
	$ git apply --stat ../0002-added-application-solutions.patch
	app/controllers/application_controller.rb | 1 +
	app/controllers/foos_controller.rb | 1 +
	app/models/foo.rb | 1 +
	spec/requests/foo_api_error_reportings_spec.rb | 10 ----------
	4 files changed, 3 insertions(+), 10 deletions(-)
	$ git apply --check ../0002-added-application-solutions.patch
	$ git am --signoff < ../0002-added-application-solutions.patch
	Applying: added application solutions
	$ bundle exec rspec

Version: 2017-02-03
