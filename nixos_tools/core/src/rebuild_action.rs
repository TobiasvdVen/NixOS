use duct::cmd;

use crate::hardware_configuration_source::HardwareConfigurationSource;
use crate::rebuild_mode::RebuildMode;
use crate::rebuild_target::RebuildTarget;

pub struct RebuildAction
{
    pub mode: RebuildMode,
    pub target: RebuildTarget,
    pub hardware_configuration_source: Option<HardwareConfigurationSource>
}

impl RebuildAction
{
    pub fn execute(&self) -> anyhow::Result<String, anyhow::Error>
    {
        Err(anyhow::format_err!("not implemented"))
    }
}
