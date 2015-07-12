#some utility functions to be shared between separate functional step files

@then(u'the command should succeed')
def step_impl(context):
    assert context.check_returncode == 0

@then(u'it should abort with a failure')
@then(u'the command should fail')
def step_impl(context):
    assert ( int(context.check_returncode) and context.check_returncode > 0 )

@then(u'there should be no output')
def step_impl(context):
    assert context.check_output==""

