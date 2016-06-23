import os, subprocess, re
from behave import * 
@given(u'that I have an excludes file excluding a cache file')
def step_impl(context):
    assert os.path.isfile("features/test-data/excludes")
    context.test_dir_path="features/test-data/basic-testdir"

@when(u'I run inventory using that excludes file')
def step_impl(context):
    context.output=subprocess.check_output(["./inventory.sh", "-x", "features/test-data/excludes", context.test_dir_path])

@then(u'the cache file should be ignored')
def step_impl(context):
    ex="cache"
    p= re.compile( ex, re.DOTALL )
    assert p.match(context.output)    
