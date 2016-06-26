import os, subprocess, re
from behave import * 
@given(u'that I have an excludes file excluding a .cache directory')
def step_impl(context):
    assert os.path.isfile("features/test-data/excludes")
    context.test_dir_path="features/test-data/excludes-testdir"

@when(u'I run inventory using that excludes file')
def step_impl(context):
    context.output=subprocess.check_output(["./inventory.sh", "-x", "features/test-data/excludes", context.test_dir_path])

@then(u'the .cache directory should not be included in the inventory')
def step_impl(context):
    ex="excluded"
    p= re.compile( ex, re.DOTALL )
    assert not p.search(context.output)    

@then(u'the keep-dir and keep-file should be included in the inventory')
def step_impl(context):
    file_ex="keep-file"
    file_p= re.compile( file_ex, re.DOTALL )
    assert file_p.search(context.output)    
    dir_ex="keep-dir"
    dir_p= re.compile( dir_ex, re.DOTALL )
    assert dir_p.search(context.output)    


@given(u'that I have an excludes file name that doesn\'t exist')
def step_impl(context):
    assert not os.path.isfile("features/test-data/excludes-noexist")
    context.test_dir_path="features/test-data/basic-testdir"

@when(u'I run inventory using that file name')
def step_impl(context):
    try:
        context.output=subprocess.check_output(["./inventory.sh", "-x", "features/test-data/excludes-noexist", context.test_dir_path], stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        context.exception=e
        return
    assert 0 # not reached

@then(u'the program should return an error')
def step_impl(context):
    ex="no such file"
    p=re.compile( ex, re.DOTALL )
    assert p.search(context.exception.output)    
    

