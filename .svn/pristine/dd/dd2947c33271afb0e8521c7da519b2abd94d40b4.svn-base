package com.jfinal.core;

import org.boilit.bsl.Engine;
import org.boilit.bsl.IEngine;
import com.jfinal.config.Constants;
import com.jfinal.plugin.IPlugin;
import com.jfinal.render.Render;
import com.jfinal.render.RenderFactory;
import com.web.render.BslRender;

/**
 * Bsl模版视图插件
 * 
 * @author lucio
 *
 */
public class BslPlugin implements IPlugin {
	private static IEngine engine = null;
	private String baseViewPath;

	public static IEngine getEngine() {
		return engine;
	}

	public BslPlugin() {
	}

	public BslPlugin(String baseViewPath) {
		this.baseViewPath = baseViewPath;
	}

	@Override
	public boolean start() {
		try {
			if (null != this.baseViewPath) {
				BslRender.WEB_BASE = this.baseViewPath;
			}
			Constants c = Config.getConstants();
			c.setRenderFactory(new RenderFactory() {
				@Override
				public Render getRender(String view) {
					return new BslRender(view);
				}
			});
			engine = Engine.getEngine();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	@Override
	public boolean stop() {
		if (null != engine && engine.isUseTemplateCache()) {
			engine.getTemplateCache().clear();
			engine = null;
		}
		return true;
	}

}
