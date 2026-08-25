use nixos_tools_core::rebuild_action::RebuildAction;

#[derive(Default)]
pub struct AppModel
{
    pub last_result: Option<Result<String, anyhow::Error>>
}

impl AppModel
{
    pub fn update(&mut self, rebuild_action: RebuildAction)
    {
        self.last_result = Some(rebuild_action.execute());
    }
}
