import os, subprocess, re
from behave import *

@given(u'that I have made an inventory file for that directory')
def step_impl(context):
    with open("inventory-file", 'w') as ivfile:
        subprocess.call(["./inventory.sh", context.test_dir_path], stdout=ivfile )
    assert os.path.isfile("inventory-file")
    assert os.path.getsize("inventory-file") > 2
    context.inventory_path="inventory-file"

@when(u'I run inventory -c on the inventory file')
def step_impl(context):
    try:
        context.check_output=subprocess.check_output(["./inventory.sh", "-c", "-i",
                                                      context.inventory_path, context.test_dir_path])
        context.check_returncode=0
    except subprocess.CalledProcessError as e:
        context.check_output=e.output
        context.check_returncode=e.returncode

@when(u'I run inventory -c -v on the inventory file')
def step_impl(context):
    try:
        context.check_output=subprocess.check_output(["./inventory.sh", "-c", "-v", "-i",
                                                      context.inventory_path, context.test_dir_path])
        context.check_returncode=0
    except subprocess.CalledProcessError as e:
        context.check_output=e.output
        context.check_returncode=e.returncode

@then(u'print out the corrupted filename')
def step_impl(context):
    assert re.compile(r".*\./hi", re.DOTALL).match(context.check_output)

@then(u'print out the missing filename')
def step_impl(context):
    assert re.compile(r".*\./hello", re.DOTALL).match(context.check_output)

@given(u'that I have made an inventory file for that directory with one file corrupted')
def step_impl(context):
    context.inventory_path="features/test-data/inventory-file-with-corrupt"

@given(u'that I have made an inventory file for that directory with one additional file')
def step_impl(context):
    context.inventory_path="features/test-data/inventory-file-with-missing"

@then(u'there should be output showing that files are okay')
def step_impl(context):
    assert re.compile(r".*\./hi: OK\n", re.DOTALL).match(context.check_output)
