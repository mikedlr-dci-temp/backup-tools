import os, subprocess

@when(u'I run shellcheck on inventory.sh')
def step_impl(context):
    try: 
        context.check_output=subprocess.check_output(["shellcheck", "inventory.sh" ])
        context.check_returncode=0
    except subprocess.CalledProcessError as e:
        context.check_output=e.output
        context.check_returncode=e.returncode

@then(u'the shellcheck command should succeed')
def step_impl(context):
    raise NotImplementedError(u'STEP: Then the shellcheck command should succeed')
